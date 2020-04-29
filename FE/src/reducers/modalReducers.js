import {
  CLOSE_MODAL,
  OPEN_MODAL,
  SET_TARGET_PROFILE,
} from "../actions/modalAction";

const initState = {
  on: false,
  targetProfile: {},
};

const reducer = (state = initState, action) => {
  const { type, payload } = action;

  switch (type) {
    case OPEN_MODAL:
    case CLOSE_MODAL:
      return { ...state, on: payload };
    case SET_TARGET_PROFILE:
      return { ...state, targetProfile: payload };
    default:
      return state;
  }
};

export default reducer;
