# frozen_string_literal: true

require 'gemoji'
require 'date'

Emoji.create('I am a witness') do |emoji|
  emoji.add_unicode_alias "\u{1f441}\u{200d}\u{1f5e8}"
end

zwj = {
  'male' => "\u{2642}",
  'female' => "\u{2640}",
  'skin-tone-1' => "\u{1f3fb}",
  'skin-tone-2' => "\u{1f3fb}",
  'skin-tone-3' => "\u{1f3fd}",
  'skin-tone-4' => "\u{1f3fe}",
  'skin-tone-5' => "\u{1f3ff}"
}

zwj.each do |name, raw|
  Emoji.create(name) do |emoji|
    emoji.add_unicode_alias raw
  end
end

propertized_strings = Emoji.all.uniq.reject do |e|
  e.raw.nil?
end.sort_by(&:name).map do |e|
  "    #(\":#{e.name}:\" 0 1 (:unicode \"#{e.raw}\"))"
end.join("\n")

header = <<~EOF
  ;;; company-emoji-list.el --- Unicode emoji as propertized strings

  ;; Copyright (C) #{Date.today.year} Alex Dunn

  ;; This program is free software; you can redistribute it and/or modify
  ;; it under the terms of the GNU General Public License as published by
  ;; the Free Software Foundation, either version 3 of the License, or
  ;; (at your option) any later version.

  ;; This program is distributed in the hope that it will be useful,
  ;; but WITHOUT ANY WARRANTY; without even the implied warranty of
  ;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ;; GNU General Public License for more details.

  ;; You should have received a copy of the GNU General Public License
  ;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

  ;;; Commentary:

  ;;; Code:

  (defun company-emoji-list-create ()
    "Return the propertized list of emoji."
  ;; See
  ;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Text-Props-and-Strings.html
  ;; for the syntax.
    (list
EOF

footer = <<~EOF
      )
    )

  (provide 'company-emoji-list)

  ;;; company-emoji-list.el ends here
EOF

puts "#{header}#{propertized_strings}\n#{footer}"
