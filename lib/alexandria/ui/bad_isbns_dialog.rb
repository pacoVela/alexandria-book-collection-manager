# frozen_string_literal: true

# This file is part of Alexandria.
#
# See the file README.md for authorship and licensing information.

module Alexandria
  module UI
    # Generalized Dialog for lists of bad isbns. Used for on_import. Can also
    # be used for on_load library conversions.
    class BadIsbnsDialog
      def initialize(parent, message, list)
        @dialog = Gtk::MessageDialog.new(parent: parent,
                                         flags: :modal,
                                         type: :warning,
                                         buttons: :close,
                                         message: message)
        the_vbox = @dialog.children.first

        isbn_container = Gtk::Box.new :horizontal
        the_vbox.pack_start(isbn_container)
        the_vbox.reorder_child(isbn_container, 3)
        scrolley = Gtk::ScrolledWindow.new
        isbn_container.pack_start(scrolley)
        textview = Gtk::TextView.new(Gtk::TextBuffer.new)
        textview.editable = false
        textview.cursor_visible = false
        scrolley.add(textview)
        list.each do |li|
          textview.buffer.insert_at_cursor("#{li}\n")
        end

        @dialog.signal_connect("response") { @dialog.destroy }
      end

      def show
        @dialog.show_all
      end
    end
  end
end
