require 'fox16'

include Fox

class EditDialog < FXDialogBox
  def initialize(owner, input)
    super(owner, "Edit User", DECOR_TITLE|DECOR_BORDER|DECOR_RESIZE)
    input.each do |row|
      @reg_target = FXDataTarget.new(row['reg_number'])
      @login_target = FXDataTarget.new(row['login_id'])
      @name_target = FXDataTarget.new(row['name'])
      @category_target = FXDataTarget.new(row['category'])
      @comment_target = FXDataTarget.new(row['comments'])
      @extragroup_target = FXDataTarget.new(row['extragroups'])
      @extraalias_target = FXDataTarget.new(row['extraalias'])
      @ucla_logon_target = FXDataTarget.new(row['uclalogon'])
    end

    edit_form
  end

  def edit_form
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

    cancel_button = FXButton.new(buttons, 'Cancel', target: self, selector: FXDialogBox::ID_CANCEL)
    update_button = FXButton.new(buttons, 'Update')    
  end
end