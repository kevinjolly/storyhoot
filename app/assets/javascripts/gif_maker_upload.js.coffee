if $('#gif-upload-container').length

  uploadedFile = undefined

  # function to render uploaded gif
  renderImage = (file) ->

    reader = new FileReader()

    reader.onload = (event) -> 
      the_url = event.target.result
      $("#uploaded-gif-container").append("<img src='" + the_url + "' width='250px' class='uploaded-image' />")
   
    reader.readAsDataURL(file)


  $('#upload-gif-file-input').change ->
    uploadedFile = this.files[0]
    renderImage(uploadedFile)

    $('#save-gif-form').css('display', 'block')

    $('#save-gif-button').click (e)->
      e.preventDefault()

      if $('#gif-category').val() == '0'
        swal
          title: 'Please select a category'
          type: 'info'
          confirmButtonText: "OK"
          confirmButtonColor: "#1fa686"
        return

      fd = new FormData
      fd.append 'book[cover]', uploadedFile
      fd.append 'book[title]', $('#gif-title').val()
      fd.append 'book[category_id]', $('#gif-category').val()

      $.ajax(
        url: "/books"
        type: "POST"
        data: fd
        processData: false
        contentType: false
      )
    

