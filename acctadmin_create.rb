require 'fox16'
include Fox

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

    cancel_button = FXButton.new(buttons, 'Cancel', target: self, selector: FXDialogBox::ID_CANCEL)
    create_button = FXButton.new(buttons, 'Create')

    create_button.connect(SEL_COMMAND) do
      new_user = {
                  reg_number: @reg_target.value, 
                  login_id: @login_target.value, 
                  name: @name_target.value, 
                  category: @category_target.value, 
                  comments: @comment_target.value, 
                  extragroups: @extragroup_target.value, 
                  extraalias: @extraalias_target.value, 
                  ucla_logon: @ucla_logon_target.value
                }

      # Required fields check
      required_fields = true
      [:reg_number, :login_id, :name, :category].each do |field|
        if new_user[field].empty?
          FXMessageBox.error(
          self, MBOX_OK, "Error", "#{field} is a required field.")
          required_fields = false
          break
        end
      end

      if required_fields
        puts 'required fields passes...do validation here'
      else
        puts 'required fields does not pass, have them revise'
      end
    end
  end
end
