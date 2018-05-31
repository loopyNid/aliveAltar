s.boot;
SerialPort.listDevices;
(
~ino = ArduinoSMS("/dev/ttyACM3", 115200);
~sample = Buffer.read(s, Platform.userHomeDir +/+ "aliveAltar/samples/mainDis.wav");
~sample2 = Buffer.read(s, Platform.userHomeDir +/+ "aliveAltar/samples/peace.wav");
f = 0.01;
v = 0.1;
~v2 = 0;
~v3 = 0;
~val1 = 0;
~val2 = 0;
~val3 = 0;
~val4 = 0;
SynthDef(\testSynth, {|freq = 200, amp|
	Out.ar(0, SinOsc.ar(freq) * amp);
}).add;
SynthDef(\testSynth2, {|amp|
	var src;
	src = PlayBuf.ar(2, 1, loop: 1, rate: 1);
	Out.ar(0, src*amp*2);
}).add;
SynthDef(\disaster, {|amp|
	var src;
	src = PlayBuf.ar(2, 0, loop: 1, rate: 1);
	Out.ar(0, src*amp*2);
}).add;
)
(
s.sendMsg(\s_new, \disaster, 2000, 0, 1);
s.sendMsg(\s_new, \testSynth, 3000, 0, 1);
s.sendMsg(\s_new, \testSynth2, 1999, 0, 1);
)
~ino.action = {|msg| msg.postln;}
(
~ino.action = {|msg|
	var amsg = split(msg, $:);
	var sensor = amsg[0].asSymbol;
	var val = amsg[1].asFloat;
	if( sensor == \US1, {
		~val1 = val;
	});
	if( sensor == \US2,{
		~val2 = val;
	});
	if( sensor == \US3,{
		~val3 = val;
	});
	if( sensor == \US4,{
		~val4 = val;
	});
	if((~val1 < 70) || (~val2 < 70) || (~val3 < 70) || (~val4 < 70), {
		if(v < 1, {
			v = v + f;
			if(~v2 > 0, {
				~v2 = ~v2 - f;
			});
			if(~v3 > 0, {
				~v3 = ~v3 - f;
			});
		},{
			v = 1;
			~v2 = 0;
			~v3 = 0;
		});
		s.sendMsg(\n_set, 3000, \amp, v);
		s.sendMsg(\n_set, 2000, \amp, ~v3);
		s.sendMsg(\n_set, 1999, \amp, ~v2);
	}, {
		if(((~val1 < 140) || (~val2 < 140) || (~val3 < 140) || (~val4 < 140)), {
			if( ~v2 < 1, {
				~v2 = ~v2 + f;
				if(~v3 > 0, {
					~v3 = ~v3 - f;
				});
				if(v > 0, {
					v = v - f;
				});
			},{
				v = 0;
				~v2 = 1;
				~v3 = 0;
			});
			s.sendMsg(\n_set, 3000, \amp, v);
			s.sendMsg(\n_set, 2000, \amp, ~v3);
			s.sendMsg(\n_set, 1999, \amp, ~v2);
		},
			{
			if( ~v3 < 1, {
				if(v > 0, {
					v = v - f;
				});
				if(~v2 > 0, {
					~v2 = ~v2 - f;
				});
					~v3 = ~v3 + f;
			},{
				v = 0;
				~v2 = 0;
				~v3 = 1;
			});
			s.sendMsg(\n_set, 3000, \amp, v);
			s.sendMsg(\n_set, 2000, \amp, ~v3);
			s.sendMsg(\n_set, 1999, \amp, ~v2);
			}
		);
		
	
	}
	);
	
	// if( sensor == \US1, { s.sendMsg(\n_set, 3000, \freq, val*10); val.postln });
	
}
)