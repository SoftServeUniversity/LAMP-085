// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require twitter/bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require dataTables/extras/TableTools
//= require highcharts
//= require highcharts/highcharts-more
//= require highcharts/themes/grid
//= require_tree .

$(document).ready(function() {
  $('#select-month').attr('disabled', true)

  $('#select-year').click(function() {
    currentYear = (new Date).getUTCFullYear()
    if ($(this).val() == currentYear){
      $('#select-month').attr('disabled', false)      
    }
    else {
      $('#select-month').attr('disabled', true) 
    }
  })
});

