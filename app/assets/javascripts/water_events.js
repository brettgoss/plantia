// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on("ajax:success", "form", function(status, data, xhr){
   $(`.message${data.plant_id}`).text("Plant Watered!");
   $(`.message${data.plant_id}`).show().delay(1000).fadeOut();

   console.log('status');
   console.log('data', data.plant_id);
});
