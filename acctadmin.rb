#!/home/jliu/.rbenv/shims/ruby

require 'fox16'
require_relative 'acctadmin_create'
require_relative 'acctadmin_search'

include Fox

class Acctadmin < FXMainWindow
  def initialize(app)
    super(app, 'Acctadmin', width: 200, height: 200)
    @app = app
    option_menu
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def option_menu
    matrix = FXMatrix.new(self, 3, opts: MATRIX_BY_ROWS|LAYOUT_CENTER_X|LAYOUT_CENTER_Y, vSpacing: 8)
    createButton = FXButton.new(matrix, "Create User", opts: BUTTON_NORMAL|LAYOUT_FILL_X, padding: 4)
    searchButton = FXButton.new(matrix, "Search Users", opts: BUTTON_NORMAL|LAYOUT_FILL_X, padding: 4)
    quitButton = FXButton.new(matrix, "Quit", opts: BUTTON_NORMAL|LAYOUT_FILL_X, padding: 4)

    createButton.connect(SEL_COMMAND, method(:launch_create))
    searchButton.connect(SEL_COMMAND, method(:launch_search))
    quitButton.connect(SEL_COMMAND) { exit }
  end

  def launch_create(sender, sel, ptr)
    CreateDialog.new(self).execute
    return 1
  end

  def launch_search(sender, sel, ptr)
    SearchDialog.new(self, @app).execute
    return 1
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    Acctadmin.new(app)
    app.create
    app.run
  end
end