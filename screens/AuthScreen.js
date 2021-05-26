import React, { useState, useReducer, useCallback, useEffect } from 'react';
import { 
  View, 
  StyleSheet, 
  Button, 
  ScrollView, 
  KeyboardAvoidingView, 
  ActivityIndicator, 
  Alert,
  ImageBackground,
  Image
} from 'react-native';
import { useDispatch } from 'react-redux';

import Card from '../components/Card';
import Input from '../components/Input';
import Colors from '../constants/Colors';
import * as authActions from '../store/actions/auth';

const FORM_INPUT_UPDATE = 'FORM_INPUT_UPDATE';

const formReducer = (state, action) => {
  if (action.type === FORM_INPUT_UPDATE) {
    const updatedValues = {
      ...state.inputValues,
      [action.input]: action.value
    };
    const updatedValidities = {
      ...state.inputValidities,
      [action.input]: action.isValid
    };
    let updatedFormIsValid = true;
    for (const key in updatedValidities) {
      updatedFormIsValid = updatedFormIsValid && updatedValidities[key];
    }
    return {
      formIsValid: updatedFormIsValid,
      inputValidities: updatedValidities,
      inputValues: updatedValues
    };
  }
  return state;
};

const AuthScreen = props => {
  const [ isLoading, setIsLoading ] = useState(false);
  const dispatch = useDispatch();
  const [ error, setError ] = useState();
  const [ isSignup, setIsSignup ] = useState(true); 
  const [formState, dispatchFormState] = useReducer(formReducer, {
    inputValues: {
      email: '',
      password: ''
    },
    inputValidities: {
      email: false,
      password: false
    },
    formIsValid: false
  });

  useEffect(() => {
    if (error) {
      Alert.alert('An Error Occured!', error, [{text: 'Okay'}]);
    }
  }, [error]);

  const inputChangeHandler = useCallback(
    (inputIdentifier, inputValue, inputValidity) => {
      dispatchFormState({
        type: FORM_INPUT_UPDATE,
        value: inputValue,
        isValid: inputValidity,
        input: inputIdentifier
      });
    }, 
    [dispatchFormState]
  );

  const authHandler = async () => {
    let action;
    if (isSignup) {
      action = authActions.signup(
        formState.inputValues.email,
        formState.inputValues.password
      );
    } else {
      action = authActions.login(
        formState.inputValues.email,
        formState.inputValues.password
      );
    }
    setError(null);
    setIsLoading(true);
    try {
      await dispatch(action);
    } catch (error) {
      setError(error.message);
    }
    
    setIsLoading(false);
  }

  return (
    <KeyboardAvoidingView 
      behavior='padding'
      keyboardVerticalOffset={50}
      style={styles.screen}
    >
      <Image source={require('../assets/logo.png')} style={styles.image} />
      <Card style={styles.authContainer} >
        <ScrollView>
          <Input 
            id='email'
            label='Email Address' 
            keyboardType='email-address'
            required
            email
            autoCapitalize="none"
            errorText="Please enter a valid email address."
            onInputChange={inputChangeHandler}
            initialValue=""
          />
          <Input 
            id='email'
            label='Password' 
            keyboardType='default'
            secureTextEntry
            required
            minLength={5}
            autoCapitalize="none"
            errorText="Please enter a valid password."
            onInputChange={inputChangeHandler}
            initialValue=""
          />
          <View style={styles.buttonContainer}>
            {isLoading ? (
              <ActivityIndicator size='small' color={Colors.primaryColor} />
            ) : (
             <Button 
              title={isSignup ? 'Sign Up' : 'Login'}
              color='blue'
              onPress={authHandler} />
            )}
          </View>
          <Button 
            title={`Switch to ${isSignup ? 'Login' : 'Sign Up'}`}
            color='violet'
            onPress={() => setIsSignup(prevState => !prevState)} />
        </ScrollView>
      </Card>
      
    </KeyboardAvoidingView>
  );
};

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    backgroundColor: Colors.primaryColor,
    alignItems: 'center',
  },
  authContainer: {
    width: '80%',
    maxWidth: 400,
    maxHeight: 400,
    padding: 20
  },
  buttonContainer: {
    marginTop: 10
  },
  image: {
    width: 150,
    height: 40,
    marginBottom: '10%',
    marginTop: '25%'
  }
})

export default AuthScreen;