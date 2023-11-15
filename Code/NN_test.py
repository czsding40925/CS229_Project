# Import necessary libraries
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import classification_report, confusion_matrix
import numpy as np
import pandas as pd 
import csv 

file_path = 'data_main.csv'
# Assuming you have already loaded your data into a DataFrame called 'df'
df = pd.read_csv(file_path, header=None)

# Select all rows and the first 96 columns
X = df.iloc[:, :96]
y = df.iloc[:, -1] # (your vector of binary labels)

# Split the data into training and test sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Normalize the feature data
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# Define a simple neural network model
# The architecture is 96 inputs -> 50 hidden units -> 1 output unit
mlp = MLPClassifier(hidden_layer_sizes=(50,), max_iter=1000, random_state=42)

# Train the model
mlp.fit(X_train_scaled, y_train)

# Make predictions
y_pred = mlp.predict(X_test_scaled)

# Evaluate the model
print(confusion_matrix(y_test, y_pred))
print(classification_report(y_test, y_pred))
