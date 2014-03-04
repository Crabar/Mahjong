package engines
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import animation.Fade;
	import engines.events.CardEvent;
	
	[Event(name="cardOpen", type="engines.events.CardEvent")]
	[Event(name="cardClose", type="engines.events.CardEvent")]
	public class Card extends Sprite
	{
		public function Card(front:BitmapData, back:BitmapData)
		{
			_front = front;
			_back = back;
			
			initBitmap();
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, onCardClick);
		}
		
		private var _back:BitmapData;
		private var _closeTimer:Timer;
		private var _destroying:Boolean = false;
		private var _front:BitmapData;
		private var _image:Bitmap;
		private var _isOpen:Boolean = false;
		
		public function close():void
		{
			_image.bitmapData = _back;
			_isOpen = false;
			dispatchEvent(new CardEvent(CardEvent.CARD_CLOSE));
		}
		
		public function destroy(destroyTime:uint = 1000):void
		{
			_destroying = true;
			var fade:Fade = new Fade(this, destroyTime);
			fade.addEventListener(Event.COMPLETE, onFadeAnimationComplete);
			fade.play();
		}
		
		public function get front():BitmapData
		{
			return _front;
		}
		
		public function open(timeToOpen:uint = 1000):void
		{
			_image.bitmapData = _front;
			_isOpen = true;
			dispatchEvent(new CardEvent(CardEvent.CARD_OPEN));
			//
			_closeTimer = new Timer(timeToOpen, 1);
			_closeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onCloseTimerComplete, false, 0, true);
			_closeTimer.start();
		}
		
		private function initBitmap():void
		{
			_image = new Bitmap(_back);
			addChild(_image);
		}
		
		private function onCardClick(event:MouseEvent):void
		{
			if (!_isOpen)
				open();
		}
		
		private function onCloseTimerComplete(event:TimerEvent):void
		{
			if (!_destroying)
				close();
		}
		
		private function onFadeAnimationComplete(event:Event):void
		{
			if (parent)
				parent.removeChild(this);
		}
	}
}
