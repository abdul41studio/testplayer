ready = ->
  console.log($("#vid1").width())
  if gon.playlist_videojs == undefined
    player = ""
    player = videojs 'vid1',
      techOrder: ["html5", "flash"]
      sources: [{
        src: gon.video.file.url
        type: "video/mp4"}]
      width:"100%"
      height:"560"
    $(".vjs-loading-spinner").hide();
    player.overlay({
      content: "<video id='my-video' class='video-js vjs-default-skin' preload='auto' data-setup='{}' width='300' height='50' autoplay='true'><source src=#{gon.video.file.url} type='video/mp4'></video>"
      overlays: [{
        start: 3,
        end: 15,
        align: 'bottom'
      }]
    });
    $("#my-video .vjs-control-bar").hide()
  else
    previous_div = 1
    generated_div = 2
    order = 0
    player = ""
    player = videojs 'vid1',
      techOrder: ["html5", "flash"]
      sources: [{
        src: gon.playlist_videojs[order]['file_url']
        type: "video/mp4"}]
      width:"100%"
      height:"560"
    $(".vjs-loading-spinner").hide();
    setInterval (->
      if player.ended()
        put_last_div = "vid"+previous_div
        $("#"+put_last_div).after("<video autoplay=\"true\" class=\"video-js vjs-default-skin\" controls=\"\" height=\"560\" id=\"vid"+generated_div+"\" preload=\"auto\" src=\"\"></video>")
        put_div = "vid"+generated_div
        eval("videojs.players."+put_last_div+".dispose();")
        order =
        order += 1
        if order >= gon.playlist_videojs.length
          order = 0
        player = videojs put_div,
          techOrder: ["html5", "flash"]
          sources: [{
            src: gon.playlist_videojs[order]['file_url']
            type: "video/mp4"}]
          width: "100%"
          height:"560"
        $(".vjs-loading-spinner").hide();
        previous_div += 1
        generated_div += 1
      return
    ), 1000
$(document).ready ready
$(document).on "page:load", ready
