s.boot;
SerialPort.listDevices;
(
~ino = ArduinoSMS("/dev/ttyACM0", 115200);
~sample = Buffer.read(s, Platform.userHomeDir +/+ "aliveAltar/samples/naturalDisaster.wav");
f = 0.01;
v = 0.1;
~v2 = 0;
~val1 = 0;
~val2 = 0;
SynthDef(\testSynth, {|freq = 105, amp|
	Out.ar(0, SinOsc.ar(freq) * amp * 2);
}).add;
SynthDef(\disaster, {|amp|
	var src =PlayBuf.ar(2,1, loop:1, rate: -1);
	Out.ar(0, src*amp);
}).add;
)
s.sendMsg(\s_new, \testSynth, 3000, 0, 1);
s.sendMsg(\s_new, \disaster, 2000, 0, 1);
(
~ino.action = {|msg|
	var amsg = split(msg, $:);
	var sensor = amsg[0].asSymbol;
	var val = amsg[1].asFloat;
	~v2.postln;
	if( sensor == \US1, {
		~val1 = val;
	},{
		~val2 = val;
	});
	if((~val1 < 70) || (~val2 < 70) , {
		if(v < 1, {
			v = v + f;
			~v2 = ~v2 - f;
		},{
			v = 1;
			~v2 = 0;
		});
		s.sendMsg(\n_set, 3000, \amp, v);
		s.sendMsg(\n_set, 2000, \amp, ~v2);
	},{
		if( v > 0, {
			v = v - f;
			~v2 = ~v2 + f;
		},{
			v = 0;
			~v2 = 1;
		});
		s.sendMsg(\n_set, 3000, \amp, v);
		s.sendMsg(\n_set, 2000, \amp, ~v2);
	});

	// if( sensor == \US1, { s.sendMsg(\n_set, 3000, \freq, val*10); val.postln });
	
}
)