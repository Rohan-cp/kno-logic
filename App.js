import React from 'react';
import MainNavigator from './navigator/MainNavigator';
import { createStore, combineReducers, applyMiddleware } from 'redux';
import { Provider } from 'react-redux';
import AppLoading from 'expo-app-loading';
import { enableScreens } from 'react-native-screens';
import ReduxThunk from 'redux-thunk';
import { StatusBar } from 'expo-status-bar';
import { useFonts } from 'expo-font';

import { 
  Lato_100Thin,
  Lato_100Thin_Italic,
  Lato_300Light,
  Lato_300Light_Italic,
  Lato_400Regular,
  Lato_400Regular_Italic,
  Lato_700Bold,
  Lato_700Bold_Italic,
  Lato_900Black,
  Lato_900Black_Italic 
} from '@expo-google-fonts/lato'

import articlesReducer from './store/reducers/articles';
import authReducer from './store/reducers/auth';
import dateReducer from './store/reducers/date';
import tempReducer from './store/reducers/temp';
enableScreens();
const rootReducer = combineReducers({
  articles: articlesReducer,
  auth: authReducer,
  date: dateReducer,
  temp: tempReducer
});

const store = createStore(rootReducer, applyMiddleware(ReduxThunk));

export default function App() {
  let [fontsLoaded] = useFonts({
    Lato_100Thin,
    Lato_100Thin_Italic,
    Lato_300Light,
    Lato_300Light_Italic,
    Lato_400Regular,
    Lato_400Regular_Italic,
    Lato_700Bold,
    Lato_700Bold_Italic,
    Lato_900Black,
    Lato_900Black_Italic
  });

  if (!fontsLoaded) {
    return <AppLoading />;
  }
  /*
  return(
    <SafeAreaView>
      <Calendar />
    </SafeAreaView>
  );
  */
  return (
    <Provider store={store}>
      <StatusBar style="dark" />
      <MainNavigator/>
    </Provider>
  );
}

