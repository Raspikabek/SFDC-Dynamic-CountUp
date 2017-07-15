({
	scriptsLoaded : function(component, event, helper) {
		console.log("Scripts Loaded!");
		
		var easingFn = function(t, b, c, d) {
		  var ts = (t /= d) * t;
		  var tc = ts * t;
		  return b + c * (tc * ts + -5 * ts * ts + 10 * tc + -10 * ts + 5 * t);
		}
		var options = {
		  useEasing : true,
		  easingFn: easingFn,
		  useGrouping : true,
		  separator : component.get('v.t_separator'),
		  decimal : component.get('v.d_separator')
		};
		var prefix = component.get('v.prefix');
		var suffix = component.get('v.suffix');
		if(prefix != null) options.prefix = prefix;
		if(suffix != null) options.suffix = suffix;
		
		var maxValue = component.get('v.maxValue');
		var duration = component.get('v.duration');
		var decimals = component.get('v.decimals');
		var demo = new CountUp("raspisDojo_countUp_element", 0, maxValue, decimals, duration, options);
		demo.start();
	}
})