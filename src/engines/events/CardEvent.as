package engines.events
{
	import flash.events.Event;
	
	public class CardEvent extends Event
	{
		/**
		 * Dispatched when target card is closed.
		 * @default
		 */
		public static const CARD_CLOSE:String = "cardClose";
		/**
		 * Dispatched when target card is opened.
		 * @default
		 */
		public static const CARD_OPEN:String = "cardOpen";
		
		public function CardEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new CardEvent(type, bubbles, cancelable);
		}
	}
}
