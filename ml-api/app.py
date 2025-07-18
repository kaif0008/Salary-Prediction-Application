from flask import Flask, request, jsonify
import pickle

# Load your trained model
model = pickle.load(open('salary_model.pkl', 'rb'))

# Mapping for categorical features
education_map = {"High School": 1, "Bachelor": 0, "Master": 2, "PhD": 3}
location_map = {"Urban": 2, "Suburban": 1, "Rural": 0}
job_title_map = {"Engineer": 2, "Manager": 3, "Director": 1, "Analyst": 0}
gender_map = {"Male": 1, "Female": 0}

app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    print("Received Data:", data)

    try:
        # Encode categorical fields
        education = education_map[data['education']]
        location = location_map[data['location']]
        job_title = job_title_map[data['jobTitle']]
        gender = gender_map[data['gender']]

        # Build feature array for the model
        features = [
            education,              # Encoded education
            data['experience'],     # Years of experience
            location,               # Encoded location
            job_title,              # Encoded job title
            data['age'],            # Age
            gender                  # Encoded gender
        ]

        # Predict
        prediction = model.predict([features])
        result = round(prediction[0], 2)

        return jsonify({'predicted_salary': result})

    except Exception as e:
        print("Error:", e)
        return jsonify({'error': 'Invalid input or encoding failed'}), 400

# ⚠️ REMOVE this block for production (Gunicorn will run it)
# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=5001, debug=True)

