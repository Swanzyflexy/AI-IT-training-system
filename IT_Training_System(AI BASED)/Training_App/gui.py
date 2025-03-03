import random
import numpy as np
import nltk
from nltk.stem import WordNetLemmatizer
import json
import pickle
from tensorflow import keras
import validators
# Initialize the lemmatizer and load necessary data
lemmatizer = WordNetLemmatizer()
model = keras.models.load_model('chatbot_model.h5', compile=False)
intents = json.loads(open('intents.json').read())
words = pickle.load(open('words.pkl', 'rb'))
classes = pickle.load(open('classes.pkl', 'rb'))

# Function to clean up and tokenize sentences
def clean_up_sentence(sentence):
    sentence_words = nltk.word_tokenize(sentence)
    sentence_words = [lemmatizer.lemmatize(word.lower()) for word in sentence_words]
    print(f"Cleaned sentence: {sentence_words}")  # Debugging output
    return sentence_words

# Function to create bag of words
def bow(sentence, words, show_details=True):
    sentence_words = clean_up_sentence(sentence)
    bag = [0] * len(words)
    for s in sentence_words:
        for i, w in enumerate(words):
            if w == s:
                bag[i] = 1
                if show_details:
                    print(f"Found in bag: {w}")  # Debugging output
    return np.array(bag)

# Function to predict class from sentence
def predict_class(sentence, model):
    p = bow(sentence, words, show_details=False)
    res = model.predict(np.array([p]))[0]
    ERROR_THRESHOLD = 0.25
    results = [[i, r] for i, r in enumerate(res) if r > ERROR_THRESHOLD]
    results.sort(key=lambda x: x[1], reverse=True)
    
    print(f"Predicted results: {results}")  # Debugging output

    return_list = []
    for r in results:
        return_list.append({"intent": classes[r[0]], "probability": str(r[1])})
    return return_list

# Function to get response from intents
def get_response(ints, intents_json):
    if not ints:
        return "I'm sorry, I didn't understand that. Could you please rephrase?"
    
    tag = ints[0]['intent']
    list_of_intents = intents_json['intents']
    for i in list_of_intents:
        if i['tag'] == tag:
            return random.choice(i['responses'])
    
    return "I'm sorry, I didn't understand that. Could you please rephrase?"

# Function to handle chatbot response
def chatbot_response(msg):
    ints = predict_class(msg, model)
    return get_response(ints, intents)
