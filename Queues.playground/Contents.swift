

//var queue = QueueArray<String>()
//queue.enqueue("Ray")
//queue.enqueue("Brian")
//queue.enqueue("Eric")
//queue.dequeue()
//queue
//queue.peek
//
//var queueRing = QueueRingBuffer<String>(count: 10)
//queueRing.enqueue("Ray")
//queueRing.enqueue("Brian")
//queueRing.enqueue("Eric")
//queueRing
//queueRing.dequeue()
//queueRing
//queueRing.peek

var queue = QueueStack<String>()
queue.enqueue("Ray")
queue.enqueue("Brian")
queue.enqueue("Eric")
queue.enqueue("John")
queue.dequeue()
queue
queue.peek
