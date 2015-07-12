if $('#gif-maker-pictures-container').length

  imagesUrl = []

  # function to render uploaded images
  renderImage = (file) ->

    reader = new FileReader()

    reader.onload = (event) -> 
      the_url = event.target.result
      $("#uploaded-images-container").append("<img src='" + the_url + "' width='150px' class='uploaded-image' />")
   
    reader.readAsDataURL(file)


  # call renderImage() on all files on change in field
  $('#upload-images-file-input').change ->
    for file in this.files
      renderImage(file)


  # Converts data URL to blob
  dataURItoBlob = (dataURI) ->
    binary = atob(dataURI.split(',')[1])
    array = []
    i = 0
    while i < binary.length
      array.push binary.charCodeAt(i)
      i++
    new Blob([ new Uint8Array(array) ], type: 'image/gif')


  # response on clicking the create-gif-button
  $('#create-gif-button').click (e)->
    e.preventDefault()

    $('#loading-indicator').css('display', 'block')

    $('.uploaded-image').each (index)->
      imagesUrl[index] = $(this).attr('src').replace(/"+/g,"")

    console.log imagesUrl[0]

    speed = parseInt $('.range-slider').attr('data-slider'), 10
    speed = 11 - speed
    speed = speed / 10

    gifshot.createGIF
      'images': imagesUrl
      'gifWidth': 500
      'gifHeight': 500
      'interval': speed
    , (obj) ->
      unless obj.error
        image = obj.image
        animatedImage = document.createElement('img')
        animatedImage.src = image
        animatedImage.id = 'gif-completed'
        $('#created-gif-container').html("")
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

          $('#loading-indicator').css('display', 'block')

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
          ).done(->
            $('#loading-indicator').css('display', 'none')
          )
    

