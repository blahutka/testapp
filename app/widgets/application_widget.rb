class ApplicationWidget < Apotomo::Widget

  def js_modal_box(content)
    update '#modal-box .modal-body .wrap', content
  end
  
end