package engines
{
	import engines.events.CardEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
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
			_closeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onCloseTimerComplete);
		}
		
		public var destroying:Boolean = false;
		
		private var _back:BitmapData;
		private var _front:BitmapData;
		
		private var _image:Bitmap;
		private var _isOpen:Boolean = false;
		
		private const _closeTime:uint = 1000;
		private var _closeTimer:Timer = new Timer(_closeTime, 1);
		
		public function close():void
		{
			_image.bitmapData = _back;
			_isOpen = false;
			dispatchEvent(new CardEvent(CardEvent.CARD_CLOSE));
		}
		
		public function get front():BitmapData
		{
			return _front;
		}
		
		public function open():void
		{
			_image.bitmapData = _front;
			_isOpen = true;
			dispatchEvent(new CardEvent(CardEvent.CARD_OPEN));
			//
			_closeTimer.start();
		}
		
		public function destroy():void
		{
			//
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
			if (!destroying)
				close();
		}
	}
}
