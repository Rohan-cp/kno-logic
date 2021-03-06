export const GET_DAILY_DIGEST = 'GET_DAILY_DIGEST';

export const getDailyDigest = () => {
  return async dispatch => {
    const response = await fetch(
      'https://knologic.chickenkiller.com:4000/post/all'
    );

    if (response.ok) {
      console.log("success!");
    }
    const resData = await response.json();
    articles = resData;
    dispatch({type: GET_DAILY_DIGEST, articles: articles});
  };
};

export const getDateDigest = (date) => {
  return async dispatch => {
    const response = await fetch(
      'https://knologic.chickenkiller.com:4000/post/all'
    );

    if (response.ok) {
      console.log("success!");
    }
    const resData = await response.json();
    articles = resData;
    dispatch({type: GET_DAILY_DIGEST, articles: articles});
  };
};