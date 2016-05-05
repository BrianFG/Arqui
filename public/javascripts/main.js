$().ready(function () {


  function refresh_state (){
    $.getJSON("state", function(r){
      $('#life').css('width', r.life+'%').attr('aria-valuenow', r.life).html(r.life); 
      $("#money").html(r.money);
      $("#respect").html(r.respect);
      $("#fights").html(r.fights);
      $("#sector").html("Sector ").append(r.state);

    });
  }


  $("#north").click(function (){
    next_command("north");
  });

  $("#east").click(function (){
    next_command("east");
  });

  $("#west").click(function (){
    next_command("west");
  });

  $("#south").click(function (){
    next_command("south");
  });
  $("#fight").click(function (){
    next_command("fight");
  });
  $("#run").click(function (){
    next_command("run");
  });
  $("#flip_coin").click(function (){
    next_command("flip_coin");
  });






function next_command (method){
    $.getJSON("next",{method: method}, function(r){
        var color ="#f1c40f";
        if (r.message.indexOf("no valida") > -1){
          color = '#e74c3c';
        }else{

        }
        var text  = $('#text');
        var message = $('<div>').css('color' , color).html("> " + r.message);
        var instructions = $('<div>').css('color' , '#2ecc71').html("> " + r.instructions);
        text.append(message).append(instructions);
        text.scrollTop(text[0].scrollHeight);
        $("#room-desc").html(r.description);
        if(r.lost){
          $("#lose").modal("show");
          disableButtons();

        }
        if(r.won){
          $("#win").modal("show");
        }
        refresh_state();
    });
}

function disableButtons (){
    $("#north").unbind();
    $("#south").unbind();
    $("#east").unbind();
    $("#west").unbind();
    $("#fight").unbind();
    $("#run").unbind();
    $("#flip_coin").unbind();

}




  refresh_state();
  $.getJSON("next",{method: "description"}, function(r){
    $("#room-desc").html(r.description);
    $("#text").html(r.instructions);
    $("#sector").html("Sector: ").append(r.state);
  });

});