pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
-- pico-tiny-garden
-- by ethan and jurman 

function _init()
	--build_input(20,44)
	build_crt()
end

function _update60()
	--update_input()
	crt_action()
	update_crt_st()
end

function _draw()
	--draw_input()
	print(
	 crt.st..
	 ': '..crt.ti..
	 ' ('..crt.dir.x..
	 ', '..crt.dir.y..
	 ')'
	)
end
-->8
-- input logic

function build_input(x,y)
 -- create input object
	input={}
	input.val_index=1
	input.cur_index=1
	input.value=""
	input.x=x
	input.y=y
	alphabet="abcdefghijklmnopqrstuvwxyz "
end

function update_input()
 -- cursor logic
 if (btnp(⬆️)) input.val_index+=1 
 if (btnp(⬇️)) input.val_index-=1
 if (btnp(➡️)) input.cur_index+=1 
 if (btnp(⬅️)) input.cur_index-=1
 
 -- setting the string
 if (btnp(➡️)) then
  input.value=input.value..sub(alphabet,input.val_index,input.val_index)
 end

 if (btnp(⬅️)) then
  input.value=sub(input.value,0, input.cur_index-1)
 end

 input.val_index = input.val_index % 27
end

function draw_cursor()
	spr(3,4+(input.cur_index*4),-4)
	spr(3,4+(input.cur_index*4),12,1,1,false,true)
	sub_string=sub(alphabet,input.val_index,input.val_index)
	print(input.value..sub_string,10,6,7)
end

function draw_input()
 camera(-input.x, -input.y)
	cls(3)
	palt(14)
	spr(1)
	for i=1,9 do
	 spr(2,i*8,0)
	end
	spr(1,80,0,1,1,true)
	spr(1,0,8,1,1,false,true)
	for i=1,9 do
	 spr(2,i*8,8,1,1,false,true)
	end
	spr(1,80,8,1,1,true,true)
 draw_cursor()
	camera(0,0)
end
-->8
-- creature ai

-- possible states
st={}
st.walk="walk"
st.sit="sit"
st.obj="obj"

-- time between state change
state_time=300

function rnd_dir()
	return flr(rnd(3)-1)
end

function build_crt()
	crt={}
	
	-- position
	crt.x=64
	crt.y=64
	
	-- state, and how long
	-- we've been in that state
	crt.st=st.walk
	crt.ti=0
	
	-- direction,
	-- start looking right
	crt.dir={}
	crt.dir.x=1
	crt.dir.y=0
	
	-- need some object state
	-- here
end

function update_crt_st()
 -- if we've been walking for
	-- a while, either walk
	-- another direction, or sit
	if (crt.st==st.walk and 
	    crt.ti > state_time) then
	 -- should we sit or continue?
	 should_sit=rnd(4)<1
	 if (should_sit) then
	 	crt_start_sit()
		else
		 -- continue walking
		 crt_start_walk()
  end
	end
	
	-- if we've been sitting for
	-- a while, take a walk
	if (crt.st==st.sit and
	    crt.ti > state_time) then
	 crt_start_walk()
	end
end

function crt_start_sit()
	crt.st=st.sit
	crt.ti=0
end

function crt_start_walk()
	crt.st=st.walk
	crt.dir.x=rnd_dir()
	crt.dir.y=rnd_dir()
	crt.ti=0
end

function crt_action()
	-- walk action
	if (crt.st==st.walk) then
		crt.x+=crt.dir.x
		crt.y+=crt.dir.y
	end
	
	-- sitting action
	if (crt.st==st.sit) then
		-- do nothing, for now
	end
	
	-- update time
	crt.ti+=1
end

function crt_is_facing_obj(obj)
 -- are we adjacent to the obj?
 
 -- are we facing it?
 
 -- have we recently interacted
 -- with it?
end
__gfx__
00000000e7e7e77777777777eeeeeeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000077e7700000000000eeeeeeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700eee7000000000000eee00eee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770007770000000000000ee0760ee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000e700000000000000e077760e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700700000000000000007777760000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000700000000000000007777760000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000007000000000000000e000000e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
