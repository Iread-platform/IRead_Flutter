enum State { Loading, Success, Fail }

abstract class BaseBlocState {
  State state = State.Success;
}
