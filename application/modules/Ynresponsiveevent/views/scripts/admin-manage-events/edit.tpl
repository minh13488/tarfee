<script type="text/javascript">
  var myCalStart = false;
  var myCalEnd = false;

  en4.core.runonce.add(function init() 
  {
    monthList = [];
    myCal = new Calendar({ 'starttime[date]': 'M d Y', 'endtime[date]' : 'M d Y' }, {
      classes: ['event_calendar'],
      pad: 0,
      direction: 0
    });
});
</script>
<?php echo $this->form->render($this) ?>


<script type="text/javascript">
  var cal_starttime_onHideStart = function(){
    // check end date and make it the same date if it's too
    cal_endtime.calendars[0].start = new Date( $('starttime-date').value );
    // redraw calendar
    cal_endtime.navigate(cal_endtime.calendars[0], 'm', 1);
    cal_endtime.navigate(cal_endtime.calendars[0], 'm', -1);
  }
  var cal_endtime_onHideStart = function(){
    // check start date and make it the same date if it's too
    cal_starttime.calendars[0].end = new Date( $('endtime-date').value );
    // redraw calendar
    cal_starttime.navigate(cal_starttime.calendars[0], 'm', 1);
    cal_starttime.navigate(cal_starttime.calendars[0], 'm', -1);
  }
  en4.core.runonce.add(function(){
    cal_starttime_onHideStart();
    cal_endtime_onHideStart();
  });
</script>