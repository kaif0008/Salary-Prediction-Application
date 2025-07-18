package com.example.salarypredict;

public class SalaryRequest {
    private String education;   // High School, Bachelor, Master, PhD
    private int experience;     // Years of experience
    private String location;    // Urban, Suburban, Rural
    private String jobTitle;    // Engineer, Manager, Director, Analyst
    private int age;            // Age
    private String gender;      // Male, Female

    // Getters and Setters
    public String getEducation() {
        return education;
    }
    public void setEducation(String education) {
        this.education = education;
    }

    public int getExperience() {
        return experience;
    }
    public void setExperience(int experience) {
        this.experience = experience;
    }

    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }

    public String getJobTitle() {
        return jobTitle;
    }
    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    public int getAge() {
        return age;
    }
    public void setAge(int age) {
        this.age = age;
    }

    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }
}
