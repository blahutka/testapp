class ModalBoxCell < Cell::Rails

  def show(content)
    @content = content
    render 
  end

end
