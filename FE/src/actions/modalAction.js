export const OPEN_MODAL = "OPEN_MODAL";
export const CLOSE_MODAL = "CLOSE_MODAL";
export const SET_TARGET_PROFILE = "SET_TARGET_PROFILE";

export const openModal = () => ({
  type: OPEN_MODAL,
  payload: true,
});

export const closeModal = () => ({
  type: CLOSE_MODAL,
  payload: false,
});

export const setTargetProfile = (targetProfile) => ({
  type: SET_TARGET_PROFILE,
  payload: targetProfile,
});
