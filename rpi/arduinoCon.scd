s.boot;
SerialPort.listDevices;
~ino = ArduinoSMS("/dev/ttyACM0", 115200);


~ino.action = {|msg|
	var amsg = split(msg, $:);
	var sensor = amsg[0].asSymbol;
	var val = amsg[1].asFloat;
	if( sensor == \US1, { s.sendMsg(\n_set, 3000, \freq, val*10); val.postln });
	
}

SynthDef(\testSynth, {|freq = 105|
	Out.ar(0, SinOsc.ar(freq));
}).add;

s.sendMsg(\s_new, \testSynth, 3000, 0, 1);