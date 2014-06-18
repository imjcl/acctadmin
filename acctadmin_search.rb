require 'fox16'
include Fox

class SearchDialog < FXDialogBox
  def initialize(owner, app)
    super(owner, "Search Users", DECOR_TITLE|DECOR_BORDER|DECOR_RESIZE)
    @app = app
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
    cancel_button = FXButton.new(buttons, 'Cancel', target: self, selector: FXDialogBox::ID_CANCEL)
    clear_button = FXButton.new(buttons, 'Clear')
    accept_button = FXButton.new(buttons, 'Search', target: self)

    clear_button.connect(SEL_COMMAND) do 
      @name_target.value, @login_target.value, @reg_target.value = ['', '', '']
    end

    accept_button.connect(SEL_COMMAND) do |sender, selector, data|
      if @name_target.value.empty? && @login_target.value.empty? && @reg_target.value.empty?
        FXMessageBox.error(
          self, MBOX_OK, "Error", "You must search using at least one field.")
      else
        @search_values = [@name_target.value, @login_target.value, @reg_target.value].select { |val| !val.empty?}
        run_search 
      end 
    end
  end

  def run_search
    close
    @app.stopModal
    SearchResults.new(@app, @search_values).execute
    return 1
  end
end

class SearchResults < FXDialogBox
  def initialize owner, search_values
    super(owner, "Search Users", DECOR_TITLE|DECOR_BORDER|DECOR_RESIZE)
    puts search_values
  end

end
