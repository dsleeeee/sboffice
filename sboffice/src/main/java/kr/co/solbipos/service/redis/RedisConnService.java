package kr.co.solbipos.service.redis;

/**
 * @author 정용길 redis 연결 관리
 */
public interface RedisConnService {
    /**
     * Redis service enable
     */
    void enable();

    /**
     * Redis service disable
     */
    void disable();

    /**
     * Redis 서버를 사용할 수 있는지 여부
     * 
     * @return
     */
    boolean isAvailable();

    /**
     * Redis 서버를 사용할 수 없는지 여부
     * 
     * @return
     */
    boolean isNotAvailable();

    /**
     * Redis server를 사용할 수 없을때 비동기로 작동하여 Redis server 의 상태를 확인하고 Redis server가 사용 가능해지면 상태값을 enable
     * 한다.
     */
    void healthCheck();

    /**
     * Redis server 로 ping 명령어를 보내 상태를 확인한다.
     * 
     * @return
     */
    String ping();
}


