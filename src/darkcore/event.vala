namespace Darkcore {
    public enum EventTypes {
        Render
    }
    
    public delegate void EventCallback();

    public class EventManager {
        private class EventWrapper {
            public EventCallback evt;
        }

        private EventWrapper wrapper = new EventWrapper();

        public void add_callback(EventCallback evt) {
            EventWrapper wrapper = new EventWrapper();
            wrapper.evt = evt;
            this.wrapper = wrapper;
        }
        
        public void call_callback() {
            var wrapper = this.wrapper;
            wrapper.evt();
        }
    }
}
