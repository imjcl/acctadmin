#!/home/jliu/.rbenv/shims/ruby

require 'fox16'
include Fox

class Acctadmin < FXMainWindow
  def initialize(app)
    super(app, 'Acctadmin', width: 200, height: 200)
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
    SearchDialog.new(self).execute
    return 1
  end
end

class CreateDialog < FXDialogBox
  def initialize(owner)
    super(owner, "Create User", DECOR_TITLE|DECOR_BORDER|DECOR_RESIZE)
    
    @reg_target = FXDataTarget.new('')
    @login_target = FXDataTarget.new('')
    @name_target = FXDataTarget.new('')
    @category_target = FXDataTarget.new('')
    @comment_target = FXDataTarget.new('')
    @extragroup_target = FXDataTarget.new('')
    @extraalias_target = FXDataTarget.new('')
    @ucla_logon_target = FXDataTarget.new('')

    create_form
  end

  def create_form
    packer = FXPacker.new(self, opts: LAYOUT_FILL)
    matrix = FXMatrix.new(packer, 2, opts: MATRIX_BY_COLUMNS|LAYOUT_CENTER_X, padding: 8, vSpacing: 8)

    FXLabel.new(matrix, 'Reg Number')
    FXTextField.new(matrix, 25, target: @reg_target, selector: FXDataTarget::ID_VALUE)

    FXLabel.new(matrix, 'Login ID')
    FXTextField.new(matrix, 25, target: @login_target, selector: FXDataTarget::ID_VALUE)

    FXLabel.new(matrix, 'Name')
    FXTextField.new(matrix, 25, target: @name_target, selector: FXDataTarget::ID_VALUE)

    FXLabel.new(matrix, 'Category')
    FXTextField.new(matrix, 25, target: @category_target, selector: FXDataTarget::ID_VALUE)

    FXLabel.new(matrix, 'Comment')
    FXTextField.new(matrix, 25, target: @comment_target, selector: FXDataTarget::ID_VALUE)

    FXLabel.new(matrix, 'Extra Groups')
    FXTextField.new(matrix, 25, target: @extragroup_target, selector: FXDataTarget::ID_VALUE)

    FXLabel.new(matrix, 'Extra Aliases')
    FXTextField.new(matrix, 25, target: @extraalias_target, selector: FXDataTarget::ID_VALUE)

    FXLabel.new(matrix, 'UCLA Logon')
    FXTextField.new(matrix, 25, target: @ucla_logon_target, selector: FXDataTarget::ID_VALUE)


    buttons = FXHorizontalFrame.new(packer, opts: LAYOUT_CENTER_X|PACK_UNIFORM_HEIGHT|PACK_UNIFORM_WIDTH, hSpacing: 8)

    FXButton.new(buttons, 'Cancel')
    FXButton.new(buttons, 'Create')
  end
end

class SearchDialog < FXDialogBox
  def initialize(owner)
    super(owner, "Search Users", DECOR_TITLE|DECOR_BORDER|DECOR_RESIZE)
    search_form
  end

  def search_form
    packer = FXPacker.new(self, :opts => LAYOUT_FILL)
    matrix = FXMatrix.new(packer, 2, opts: MATRIX_BY_COLUMNS|LAYOUT_CENTER_X, padding: 8, vSpacing: 8)

    @name_target = FXDataTarget.new('')
    @login_target = FXDataTarget.new('')
    @reg_target = FXDataTarget.new('')
    
    FXLabel.new(matrix, 'Name:')
    name_text = FXTextField.new(matrix, 25, target: @name_target, selector: FXDataTarget::ID_VALUE)
    
    FXLabel.new(matrix, 'Login ID:')
    login_text = FXTextField.new(matrix, 25, target: @login_target, selector: FXDataTarget::ID_VALUE)
    
    FXLabel.new(matrix, 'Reg Number:')
    reg_text = FXTextField.new(matrix, 25, target: @reg_target, selector: FXDataTarget::ID_VALUE)

    buttons = FXHorizontalFrame.new(packer, opts: LAYOUT_CENTER_X|PACK_UNIFORM_HEIGHT|PACK_UNIFORM_WIDTH, hSpacing: 8)
    cancel_button = FXButton.new(buttons, 'Cancel')
    clear_button = FXButton.new(buttons, 'Clear')
    accept_button = FXButton.new(buttons, 'Search')

    accept_button.connect(SEL_COMMAND) do
      puts "This name is #{@name_target.value}"
    end
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    Acctadmin.new(app)
    app.create
    app.run
  end
end