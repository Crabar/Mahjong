package animation
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	[Event(name="complete", type="flash.events.Event")]
	public class Fade extends EventDispatcher
	{
		public function Fade(target:Sprite, time:uint, goDown:Boolean = true)
		{
			_goDown = goDown;
			_target = target;
			_changeFactor = (time / 1000) / target.stage.frameRate;
			_animationTimer = new Timer(time, 1);
			_animationTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onAnimationEnd);
		}
		
		private var _animationTimer:Timer;
		private var _changeFactor:Number;
		private var _target:Sprite;

		public function get target():Sprite
		{
			return _target;
		}

		private var _goDown:Boolean;
		
		private function onAnimationEnd(event:TimerEvent):void
		{
			_target.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onEnterFrame(event:Event):void
		{
			if (_goDown)
				_target.alpha -= _changeFactor;
			else
				_target.alpha += _changeFactor;
		}
		
		public function play():void
		{
			_animationTimer.start();
			_target.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
	}
}