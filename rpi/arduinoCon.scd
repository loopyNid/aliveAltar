s.boot;
SerialPort.listDevices;
~ino = ArduinoSMS("/dev/ttyACM3", 115200);
f = 0.01;
v = 0.1;
(
~ino.action = {|msg|
	var amsg = split(msg, $:);
	var sensor = amsg[0].asSymbol;
	var val = amsg[1].asFloat;
	v.postln;
	if( sensor == \US1, {
		~val1 = val;
	},{
		~val2 = val;
	});
	if((~val1 < 70) || (~val2 < 70) , {
		if(v < 1, {
			v = v + f;
		},{
			v = 1;
		});
		s.sendMsg(\n_set, 3000, \amp, v);
	},{
		if( v > 0, {
			v = v - f;
		},{
			v = 0;
		});
		s.sendMsg(\n_set, 3000, \amp, v);
	});

	// if( sensor == \US1, { s.sendMsg(\n_set, 3000, \freq, val*10); val.postln });
	
}
)

SynthDef(\testSynth, {|freq = 105, amp|
	Out.ar(0, SinOsc.ar(freq) * amp * 2);
}).add;

s.sendMsg(\s_new, \testSynth, 3000, 0, 1);