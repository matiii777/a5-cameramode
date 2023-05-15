let Moving = {}
let SelectedId = 0
let SelectedPic = 'Pick a picture first !'
let isCamera = false
let LatestScreenshot = null
let BlurType = false
let AmTooLazyToFixThisInABetterWay = false
let galleryphoto = 1.14
let ControlPressed = false
let WaitBeforeTakingAnotherPicture = false
let GalleryToggle = false

window.addEventListener('message', function(event) {
    switch(event.data.action) {
        case "opencam":
            $('.photomodecontainer').fadeIn(0)
            isCamera = true
            DestroyAllSliders();
            CreateAllSliders(Moving);
            $.post(`https://${GetParentResourceName()}/CameraMode`, {});
            break;
        case "Setup":
            SetupCameraMode(event.data.Settings, event.data.Pictures)
            break;
        case "CopyScreenshotUrl":
            ScreenShot(event.data)
            break;
    }
})

$(document).on('keydown', function(){
    switch(event.keyCode) {
      case 27:
        if(isCamera) {
            $('.photomodecontainer').fadeOut(0)
            $.post(`https://${GetParentResourceName()}/SetUpCameraMovement`, JSON.stringify({}));
            $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
            isCamera = false
        }
        break;
    }
});

// -- camera mode --
SetupCameraMode =  async function () {
    let push = await $.post(`https://${GetParentResourceName()}/getCamsData`);

    if (!push.Settings.CameraButton) {
        $('.nakedcamerabutton').hide(0)
    }
    Moving.x = push.Settings.MovingX
    Moving.y = push.Settings.MovingY
    Moving.z = push.Settings.MovingZ
    Moving.fov = push.Settings.MovingFov
    Moving.MaxFilter = push.Settings.MaxFilterStrength
    CreateAllSliders(Moving);
    var elem = push.Settings.Cameramodeheader
    +'<div class="headerbuttonscontainer" style="width: 2vh;">'
        +'<div class="headerbutton" id="closecameramode"><i class="fa-solid fa-circle-xmark"></i></div>'
    +'</div>'
    $('.photomodeheader').html(elem)
    $('#closecameramode').click(function () {
        $('.photomodecontainer').fadeOut(0)
        isCamera = false
        $.post(`https://${GetParentResourceName()}/SetUpCameraMovement`, JSON.stringify({}));
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
    });
    $('#closecameramode').mouseover(function () {
        GetCameraSounds(1);
    });

    $.each(push.Settings.Filters, function(i){
        let FilterNumber = i+1
        var elem2 = '<div class="photomodefilterbutton" id="filter'+i+'">'+'<div class="photomodefilterbuttondot" style="background-color: '+push.Settings.Filters[i].Color+';"></div> '+FilterNumber+' '+push.Settings.Filters[i].Name+'</div>'
        $('.photomodefiltersinnercontainer').append(elem2)
        $('#filter'+i).mouseover(function () {
            GetCameraSounds(1);
        });
        if (i == 0) {
            $('#filter'+i).css('background-color', 'rgb(146, 146, 146)').css('color', 'rgb(4, 4, 4)')
        }
        $('#filter'+i).click(function () {
            $('.photomodefilterbutton').each( function () {
                $(this).css('background-color', 'rgb(42, 42, 42)').css('color', 'rgb(244, 244, 244)')
            });
            $(this).css('background-color', 'rgb(146, 146, 146)').css('color', 'rgb(4, 4, 4)')
            var filter = push.Settings.Filters[i].Source
            $.post(`https://${GetParentResourceName()}/SetFilter`, JSON.stringify({filter}));
            GetCameraSounds(3);
        });
    });
    $.each(push.Pictures, function(i){
        let elem3 = '<div class="galleryphotocontainer" id="Picture'+push.Pictures[i].id+'">'
                +'<div class="galleryphotoheader">'+push.Pictures[i].name+'</div>'
                +'<img src="'+push.Pictures[i].image+'"></img>'
            +'</div>'
        $('.galleryrightcontainer').append(elem3)
        $('#Picture'+push.Pictures[i].id).click(function () {
            SelectedId = push.Pictures[i].id
            SelectedPic = push.Pictures[i].image
            $('.galleryleftinnerimage').html('<img src="'+push.Pictures[i].image+'"></img>')
            $('.gallerysavedbuttonscontainer').show()
            GetCameraSounds(3);
        });
        $('#Picture'+push.Pictures[i].id).mouseover(function () {
            GetCameraSounds(1);
        });
    });
}

ScreenShot = function (data) {
    var node = document.createElement('textarea');
    var selection = document.getSelection();
    node.textContent = data.url;
    document.body.appendChild(node);
    selection.removeAllRanges();
    node.select();
    document.execCommand('copy');
    selection.removeAllRanges();
    document.body.removeChild(node);
    LatestScreenshot = data.url
    $('.photoeditimage').html('<img src="'+data.url+'"></img>');
    $('.photoeditcontainer').show();
}

CreateAllSliders = function () {
    $("#movementone").slider({
        max: Moving.x.Max,
        min: Moving.x.Min,
        range: "min",
        step: 0.00001,
        value: 0.0,
        orientation: "horizontal",
        slide: function( event, ui ) {
            let move = {}
            move.value = ui.value
            move.type = 'x'
            $.post(`https://${GetParentResourceName()}/Movecamera`, JSON.stringify({move}));
        }
    });
    $("#movementtwo").slider({
        max: Moving.y.Max,
        min: Moving.y.Min,
        range: "min",
        step: 0.00001,
        value: 0.0,
        orientation: "horizontal",
        slide: function( event, ui ) {
            let move = {}
            move.value = ui.value
            move.type = 'y'
            $.post(`https://${GetParentResourceName()}/Movecamera`, JSON.stringify({move}));
        }
    });
    $("#movementthree").slider({
        max: Moving.z.Max,
        min: Moving.z.Min,
        range: "min",
        step: 0.00001,
        value: 0.0,
        orientation: "horizontal",
        slide: function( event, ui ) {
            let move = {}
            move.value = ui.value
            move.type = 'z'
            $.post(`https://${GetParentResourceName()}/Movecamera`, JSON.stringify({move}));
        }
    });
    $("#movementfour").slider({
        max: Moving.fov.Max,
        min: Moving.fov.Min,
        range: "min",
        step: 0.00001,
        value: 0.0,
        orientation: "horizontal",
        slide: function( event, ui ) {
            let move = {}
            move.value = ui.value
            move.type = 'fov'
            $.post(`https://${GetParentResourceName()}/Movecamera`, JSON.stringify({move}));
        }
    });
    $("#movementfive").slider({
        max: Moving.MaxFilter,
        min: 0.02,
        range: "min",
        step: 0.00001,
        value: 0.80,
        orientation: "horizontal",
        slide: function( event, ui ) {
            let Strength = ui.value
            if(Strength == 1 ||Strength == 2 ||Strength == 3 ||Strength == 4 ||Strength == 5 ||Strength == 6 || Strength == 7 ||Strength == 8 ||Strength == 9 ||Strength == 10 ||Strength == 11 ||Strength == 12) {
                Strength = ui.value+'.0'
            }
            $.post(`https://${GetParentResourceName()}/SetFilterStrength`, JSON.stringify({Strength}));
        }
    });
    BlurType = false
    $('#camerablur').html('<i class="fa-solid fa-droplet"></i>')
    if (!AmTooLazyToFixThisInABetterWay) {
        AmTooLazyToFixThisInABetterWay = true
    } else {
        $.post(`https://${GetParentResourceName()}/SetUpCameraMovement`, JSON.stringify({}));
    }
}

DestroyAllSliders = function () {
    $('.photomodefilterbutton').each(function () {
        let _this = $(this).text()
        if (_this == ' 1 No Filter') {
            $(this).css('background-color', 'rgb(146, 146, 146)').css('color', 'rgb(4, 4, 4)')
        } else {
            $(this).css('background-color', 'rgb(42, 42, 42)').css('color', 'rgb(244, 244, 244)')
        }
    });
    $("#movementone").slider('destroy');
    $("#movementtwo").slider('destroy');
    $("#movementthree").slider('destroy');
    $("#movementfour").slider('destroy');
    $("#movementfive").slider('destroy');
}

$('#camerablur').click(function () {
    if (!BlurType) {
        BlurType = true
        let blur = true
        $('#camerablur').html('<i class="fa-duotone fa-droplet"></i>')
        $.post(`https://${GetParentResourceName()}/Blurcamera`, JSON.stringify({blur}));
    } else {
        BlurType = false
        let blur = false
        $('#camerablur').html('<i class="fa-solid fa-droplet"></i>')
        $.post(`https://${GetParentResourceName()}/Blurcamera`, JSON.stringify({blur}));
    }
    GetCameraSounds(3);
});

$('#resetcameramovement').click(function () {
    DestroyAllSliders();
    CreateAllSliders(Moving);
    GetCameraSounds(3);
});

$("#filtersearch").on("keydown", function() {
    var value = this.value.toLowerCase().trim();
    $(".photomodefilterbutton").show().filter(function() {
      return $(this).text().toLowerCase().trim().indexOf(value) == -1;
    }).hide();
    if (value.length <= 1) {
        $(".photomodefilterbutton").each(function () {
            $(".photomodefilterbutton").show()
        });
    }
});

$("#gallerysearch").on("keydown", function() {
    var value = this.value.toLowerCase().trim();
    $(".galleryphotocontainer").show().filter(function() {
      return $(this).text().toLowerCase().trim().indexOf(value) == -1;
    }).hide();
    if (value.length <= 1) {
        $(".galleryphotocontainer").each(function () {
            $(".galleryphotocontainer").show()
        });
    }
});

$('.galleryleftinnerimage').bind('mousewheel DOMMouseScroll', function(event){
  if (event.originalEvent.wheelDelta > 0 || event.originalEvent.detail < 0) {
    if (galleryphoto < 2) {
        galleryphoto += 0.14
    } else if (galleryphoto >= 2) {
        galleryphoto += 0.40
    }
    if ( galleryphoto > 4 ) {
        galleryphoto = 4
    }
    if ( galleryphoto < 0.56 ) {
        galleryphoto = 0.56
    }
    $('.galleryleftinnerimage > img').css('pointer-events', 'all')
    $('.galleryleftinnerimage > img').draggable();
    $('.galleryleftinnerimage > img').draggable('enable');
    $('.galleryleftinnerimage > img').draggable({
        drag : function(e,ui){
            if(ui.position.left < -440) {
                ui.position.left = -440;
            }
            if(ui.position.top < -440) {
                ui.position.top = -440;
            }
            if(ui.position.left > 440) {
                ui.position.left = 440;
            }
            if(ui.position.top > 440) {
                ui.position.top = 440;
            }
        },
    });
    $('.galleryleftinnerimage > img').css('transform', 'scale('+galleryphoto+')')
  } else {
    if (galleryphoto < 2) {
        galleryphoto -= 0.40
    } else if (galleryphoto >= 2) {
        galleryphoto -= 0.40
    }
    if ( galleryphoto > 4 ) {
        galleryphoto = 4
    }
    if ( galleryphoto < 1 ) {
        galleryphoto = 1
        $('.galleryleftinnerimage > img').css('top', '0vh').css('left', '0vh').css('pointer-events', 'none')
        $('.galleryleftinnerimage > img').draggable();
        $('.galleryleftinnerimage > img').draggable('disable');
    }
    $('.galleryleftinnerimage > img').css('transform', 'scale('+galleryphoto+')')
  }
});

$('.galleryphotocontainer').click(function () {
    let photo = $(this).clone();
    $('.galleryleftinnerimage').html(photo)
});

$('.editphotobutton').click(function () {
    let whichedit = $(this).text();
    switch(whichedit) {
        case ' Cancel':
            $('.photoeditcontainer').hide();
            $('.photoeditimage').html('');
            break;
        case ' Copy':
            var node = document.createElement('textarea');
            var selection = document.getSelection();
            node.textContent = LatestScreenshot;
            document.body.appendChild(node);
            selection.removeAllRanges();
            node.select();
            document.execCommand('copy');
            selection.removeAllRanges();
            document.body.removeChild(node);
            $(this).html('<i class="fa-solid fa-clipboard-check"></i> Copied').css('pointer-events', 'none')
            setTimeout(() => {
                $(this).html('<i class="fa-solid fa-clipboard"></i> Copy').css('pointer-events', 'all')
            }, 1200);
            break;
        case ' Save':
            $('.savephotocontainer').fadeIn(0)
            break;
    }
    GetCameraSounds(3);
});

$(document).on('keydown', function(){
    if ($('.photomodecontainer').css('display') == 'block') {
        switch(event.keyCode) {
            case 17: // control
                ControlPressed = true
                break;
            case 67: // C
                if (ControlPressed) {
                    if (!WaitBeforeTakingAnotherPicture && $('.photoeditcontainer').css('display') == 'none') {
                        WaitBeforeTakingAnotherPicture = true
                        $.post(`https://${GetParentResourceName()}/TakeScreenShot`, JSON.stringify({}));
                        setTimeout(() => {
                            $('.flashingcontainer').fadeIn(0)
                            GetCameraSounds(2)
                            setTimeout(() => {
                                $('.flashingcontainer').fadeOut(0)
                            }, 400);
                        }, 200);
                        setTimeout(() => {
                            WaitBeforeTakingAnotherPicture = false
                        }, 2000);
                    }
                }
                break;
        }
    }
});

$(document).on('keyup', function(){
    if ($('.photomodecontainer').css('display') == 'block') {
        switch(event.keyCode) {
            case 17: // control
            ControlPressed = false
                break;
        }
    }
});

$('#takescreenshot').click(function () {
    GetCameraSounds(3)
    if (!WaitBeforeTakingAnotherPicture && $('.photoeditcontainer').css('display') == 'none') {
        WaitBeforeTakingAnotherPicture = true
        $.post(`https://${GetParentResourceName()}/TakeScreenShot`, JSON.stringify({}));
        setTimeout(() => {
            $('.flashingcontainer').fadeIn(0)
            GetCameraSounds(2)
            setTimeout(() => {
                $('.flashingcontainer').fadeOut(0)
            }, 400);
        }, 200);
        setTimeout(() => {
            WaitBeforeTakingAnotherPicture = false
        }, 2000);
    }
});

$('#gallery').click(function () {
    if (!GalleryToggle) {
        GalleryToggle = true
        $(this).css('background-color', 'rgb(32,132,152)')
        $('.gallerycontainer').show();
        GetCameraSounds(3)
    } else {
        GalleryToggle = false
        $(this).css('background-color', 'rgb(32, 32, 32)')
        $('.gallerycontainer').hide();
        GetCameraSounds(3)
    }
});

$('#closesaving').click(function () {
    $('.savephotocontainer').fadeOut(0)
    GetCameraSounds(3);
});

$('#closesaving').mouseover(function () {
    GetCameraSounds(1);
});

$('.savephotoconfirm').click(function () {
    $('.savephotocontainer').fadeOut(0)
    $('.photoeditcontainer').fadeOut(0)
    let Saving = {}
    Saving.id = Math.floor(Math.random() * 888888888)+Math.floor(Math.random() * 888888888)
    Saving.image = LatestScreenshot
    Saving.name = $('#newpicturename').val();
    $.post(`https://${GetParentResourceName()}/SavePicture`, JSON.stringify({Saving}));
    let elem = '<div class="galleryphotocontainer" id="Picture'+Saving.id+'">'
            +'<div class="galleryphotoheader">'+Saving.name+'</div>'
            +'<img src="'+Saving.image+'"></img>'
        +'</div>'
    $('.galleryrightcontainer').append(elem)
    $('#Picture'+Saving.id).click(function () {
        $('.galleryleftinnerimage').html('<img src="'+Saving.image+'"></img>')
        $('.gallerysavedbuttonscontainer').show()
        SelectedId = Saving.id
        SelectedPic = Saving.image
        GetCameraSounds(3);
    });
    $('#Picture'+Saving.id).mouseover(function () {
        GetCameraSounds(1);
    });
});

$('.savephotoconfirm').mouseover(function () {
    GetCameraSounds(1);
});

$('.gallerysavedbutton').click(function () {
    let whichedit = $(this).text();
    switch(whichedit) {
        case ' Delete':
            $.post(`https://${GetParentResourceName()}/DeletePicture`, JSON.stringify({SelectedId}));
            $('#Picture'+SelectedId).remove();
            $('.galleryleftinnerimage').html('')
            $('.gallerysavedbuttonscontainer').hide()
            break;
        case ' Copy':
            var node = document.createElement('textarea');
            var selection = document.getSelection();
            node.textContent = SelectedPic;
            document.body.appendChild(node);
            selection.removeAllRanges();
            node.select();
            document.execCommand('copy');
            selection.removeAllRanges();
            document.body.removeChild(node);
            $(this).html('<i class="fa-solid fa-clipboard-check"></i> Copied').css('pointer-events', 'none')
            setTimeout(() => {
                $(this).html('<i class="fa-solid fa-clipboard"></i> Copy').css('pointer-events', 'all')
            }, 1200);
            break;
    }
    GetCameraSounds(3);
});

$('.gallerysavedbutton').mouseover(function () {
    GetCameraSounds(1);
});

$('.photomodebuttons').mouseover(function () {
    GetCameraSounds(1);
});
$('.photomodefilterbutton').mouseover(function () {
    GetCameraSounds(1);
});
$('.editphotobutton').mouseover(function () {
    GetCameraSounds(1);
});

GetCameraSounds = function (data) {
    if ( data == 1 ) {
        var mousehover = document.getElementById("mousehover");
        mousehover.currentTime = 0
        mousehover.play();
        mousehover.volume = 0.282;
    } else if ( data == 2 ) {
        var screenshot = document.getElementById("screenshot");
        screenshot.currentTime = 0
        screenshot.play();
        screenshot.volume = 0.482;
    }
}

$(document).mousemove(function (data) {
    LeftPos = data.clientX
    TopPos = data.clientY
    var howloooong = $('.tooltipcontainer').width();
    var howtaaaall = $('.tooltipcontainer').height()/2
    if (data.clientX < 1560) {
        whichway = false
        $('.tooltipcontainer').css('left', (data.clientX+26)+'px').css('top', (data.clientY-howtaaaall)+'px')
    } else if (data.clientX >= 1560) {
        $('.tooltipcontainer').css('left', (data.clientX-howloooong-46)+'px').css('top', (data.clientY-howtaaaall)+'px')
    }
});

setTimeout(() => {
    SetupCameraMode()
}, 22);