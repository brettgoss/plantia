// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on("ajax:success", "form", function(status, data, xhr){
  if (data.plant_id === 0) {
    $(`.message${data.plant_id}`).text("All your plants have been watered!");
    $(`.message${data.plant_id}`).show().delay(1000).fadeOut();
  }
  else {
    $(`.message${data.plant_id}`).text("Plant Watered!");
    $(`.message${data.plant_id}`).show().delay(1000).fadeOut();
  }

   console.log('status');
   console.log('data', data.plant_id);
});
