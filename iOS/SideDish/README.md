# modifyNetworking 
## 트러블 슈팅
### 동시성 문제
3개의 섹션에 해당하는 데이터를 비동기적으로 받아올 때, 섹션 업데이트를 어떻게 할  것인가?

* 동시성 처리를 하지 않을 시
    * 섹션을 업데이트 하는 도중 서버로부터 새로운 데이터 도착
    * 업데이트 하는 indexPath와 현재 indexPath가 맞지 않아 에러 발생
    
따라서 동시성 처리가 필요함.
동시성 처리를 하는 방법 2가지를 생각해 봤음.

1. DispatchSemaphore
    * 하나의 section에 대한 정보를 서버에 요청하고 semaphore value를 -1 해줘서 해당 코드 블럭에 접근 하지 못하게 함.
    * 섹션을 업데이트하고 semaphore value를 +1 해줘서 해당 코드 블럭에 접근 가능하도록 함.
    * 네트워크 thread를 기다리게 하는 방식임.
2. main thread를 동기적으로 실행.
    * 네트워킹을 하는 thread는 계속해서 서버에서 정보를 받아옴.
    * tableView에서 section을 reload하는 메소드를 main thread에서 동기적으로 실행하였음.
    * DispathQueue.main.sync 내에서 실행되는 작업이 오래걸리면 그만큼 user의 interaction을 받지 못함.
    * 또한 DispathQueue.main.sync 내에서 실행되는 코드가 블락 당하면 deadlock 발생 가능성 있음. 


두 방법 모두 장단점이 있지만, 네트워크를 기다리는 속도보다 UI를 업데이트 하는 시간이 더 빠르다고 생각되며, deadlock의 위험 요소가 없다고 판단되어 main thread를 동기적으로 실행하는 방식을 택함.
