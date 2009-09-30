package game.library.objects
{
    
    /**
     * Classes with timers inherit this interface.
     */
    public interface Pauseable
    {
        /**
         * Pause the timers if they are started.
         */
        function pause():void;
        
        /**
         * Resume the timers if they were started previously.
         */
        function resume():void;

    }
}