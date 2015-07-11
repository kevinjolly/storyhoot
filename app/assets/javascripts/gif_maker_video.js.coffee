if $('#gif-maker-video-container').length

  videoInput = document.querySelector('#upload-video-file-input')
  url = undefined


  # Converts data URL to blob
  dataURItoBlob = (dataURI) ->
    binary = atob(dataURI.split(',')[1])
    array = []
    i = 0
    while i < binary.length
      array.push binary.charCodeAt(i)
      i++
    new Blob([ new Uint8Array(array) ], type: 'image/gif')


  $('#create-gif-button').click ->

    $('#loading-indicator').css('display', 'block')
  
    file = videoInput.files[0]
    reader = new FileReader()

    reader.onloadend = ->
      url = reader.result
      renderAndSaveGif()

    if file
      reader.readAsDataURL file


  renderAndSaveGif = ->
    
    gifshot.createGIF {
      video: [ url ]
      'gifWidth': 500
      'gifHeight': 500
    }, (obj) ->
      unless obj.error
        image = obj.image
        animatedImage = document.createElement('img')
        animatedImage.src = image
        animatedImage.id = 'gif-completed'
        $('#created-gif-container').empty
        $('#created-gif-container').append animatedImage
        $('#save-gif-form').css('display', 'block')
        $('#loading-indicator').css('display', 'none')

        $('html, body').animate({
            scrollTop: $("#created-gif-container").offset().top - 100
        }, 800)

        dataURI = image
        file = dataURItoBlob(dataURI)

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
          fd.append 'book[cover]', file
          fd.append 'book[title]', $('#gif-title').val()
          fd.append 'book[category_id]', $('#gif-category').val()

          $.ajax(
            url: "/story"
            type: "POST"
            data: fd
            processData: false
            contentType: false
          )
