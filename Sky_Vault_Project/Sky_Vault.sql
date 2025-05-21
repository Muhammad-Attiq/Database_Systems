
-- Sky Vault Database Implementation
-- CSC-270 Project: Muhammad Attiq
DROP SCHEMA

IF EXISTS skyvault;
	CREATE SCHEMA skyvault COLLATE = utf8_general_ci;

use skyvault;
-- Table: Monitoring_Stations
CREATE TABLE IF NOT EXISTS Monitoring_Stations (
    station_id INT PRIMARY KEY,
    location VARCHAR(100),
    altitude FLOAT,
    status ENUM('active', 'maintenance', 'offline')
);

-- Table: Sensors
CREATE TABLE IF NOT EXISTS Sensors (
    sensor_id INT PRIMARY KEY,
    station_id INT,
    type VARCHAR(50),
    last_calibration_date DATE,
    FOREIGN KEY (station_id) REFERENCES Monitoring_Stations(station_id)
);

-- Table: Solar_Events
CREATE TABLE IF NOT EXISTS Solar_Events (
    event_id INT PRIMARY KEY,
    type VARCHAR(50),
    intensity ENUM('G1','G2','G3','G4','G5'),
    detection_time DATETIME
);

-- Table: Magnetic_Readings
CREATE TABLE IF NOT EXISTS Magnetic_Readings (
    reading_id INT PRIMARY KEY,
    sensor_id INT,
    timestamp DATETIME,
    disturbance_level FLOAT,
    FOREIGN KEY (sensor_id) REFERENCES Sensors(sensor_id)
);

-- Table: Satellite_Alerts
CREATE TABLE IF NOT EXISTS Satellite_Alerts (
    alert_id INT PRIMARY KEY,
    satellite_name VARCHAR(50),
    event_id INT,
    risk_level VARCHAR(50),
    FOREIGN KEY (event_id) REFERENCES Solar_Events(event_id)
);

-- Table: Ground_Impacts
CREATE TABLE IF NOT EXISTS Ground_Impacts (
    impact_id INT PRIMARY KEY,
    location VARCHAR(100),
    event_id INT,
    effects VARCHAR(100),
    FOREIGN KEY (event_id) REFERENCES Solar_Events(event_id)
);

-- Table: Response_Protocols
CREATE TABLE IF NOT EXISTS Response_Protocols (
    protocol_id INT PRIMARY KEY,
    trigger_condition VARCHAR(100),
    action VARCHAR(100),
    priority_level INT
);

-- Table: Historical_Geostorms
CREATE TABLE IF NOT EXISTS Historical_Geostorms (
    storm_id INT PRIMARY KEY,
    year INT,
    estimated_strength VARCHAR(50),
    damage_cost DECIMAL(15,2)
);

-- Table: Equipment
CREATE TABLE IF NOT EXISTS Equipment (
    equipment_id INT PRIMARY KEY,
    station_id INT,
    type VARCHAR(50),
    sitrep VARCHAR(50),
    FOREIGN KEY (station_id) REFERENCES Monitoring_Stations(station_id)
);

-- Table: Personnel
CREATE TABLE IF NOT EXISTS Personnel (
    person_id INT PRIMARY KEY,
    name VARCHAR(100),
    role VARCHAR(50),
    station_id INT,
    FOREIGN KEY (station_id) REFERENCES Monitoring_Stations(station_id)
);


-- INSERTS --

-- Monitoring_Stations
INSERT INTO Monitoring_Stations (station_id, location, altitude, status) VALUES
(1, '37.7749° N, 122.4194° W', 16.5, 'active'),
(2, '34.0522° N, 118.2437° W', 89.2, 'maintenance'),
(3, '40.7128° N, 74.0060° W', 10.1, 'offline'),
(4, '51.5074° N, 0.1278° W', 35.3, 'active'),
(5, '35.6895° N, 139.6917° E', 40.0, 'active'),
(6, '55.7558° N, 37.6173° E', 144.3, 'maintenance'),
(7, '28.6139° N, 77.2090° E', 216.8, 'active'),
(8, '19.0760° N, 72.8777° E', 14.0, 'offline'),
(9, '48.8566° N, 2.3522° E', 75.0, 'active'),
(10, '52.5200° N, 13.4050° E', 34.1, 'maintenance'),
(11, '31.7683° N, 35.2137° E', 754.0, 'active'),
(12, '41.9028° N, 12.4964° E', 21.0, 'active'),
(13, '1.3521° N, 103.8198° E', 15.3, 'offline'),
(14, '45.4215° N, 75.6972° W', 70.0, 'maintenance'),
(15, '33.6844° N, 73.0479° E', 508.0, 'active');

-- Sensors
INSERT INTO Sensors (sensor_id, station_id, type, last_calibration_date) VALUES
(1, 1, 'magnetometer', '2025-01-12'),
(2, 1, 'spectrometer', '2024-12-05'),
(3, 2, 'radiometer', '2025-03-10'),
(4, 3, 'magnetometer', '2025-02-18'),
(5, 4, 'spectrometer', '2024-11-15'),
(6, 5, 'infrared sensor', '2024-12-22'),
(7, 6, 'magnetometer', '2025-01-01'),
(8, 7, 'gamma detector', '2024-10-30'),
(9, 8, 'magnetometer', '2025-01-20'),
(10, 9, 'spectrometer', '2025-02-28'),
(11, 10, 'ultraviolet sensor', '2024-09-09'),
(12, 11, 'magnetometer', '2025-03-01'),
(13, 12, 'radiometer', '2025-01-15'),
(14, 13, 'gamma detector', '2025-02-10'),
(15, 14, 'spectrometer', '2025-03-05');

-- Solar_Events
INSERT INTO Solar_Events (event_id, type, intensity, detection_time) VALUES
(1, 'solar flare', 'G3', '2025-03-12 14:30:00'),
(2, 'CME', 'G2', '2025-02-27 11:10:00'),
(3, 'solar wind', 'G1', '2025-04-01 06:45:00'),
(4, 'solar flare', 'G4', '2025-01-20 23:50:00'),
(5, 'CME', 'G5', '2025-03-03 13:25:00'),
(6, 'solar wind', 'G1', '2025-04-05 04:00:00'),
(7, 'solar flare', 'G2', '2025-01-10 18:00:00'),
(8, 'CME', 'G3', '2025-03-15 09:10:00'),
(9, 'solar wind', 'G1', '2025-02-22 05:00:00'),
(10, 'solar flare', 'G4', '2025-03-28 12:30:00'),
(11, 'CME', 'G3', '2025-01-05 07:25:00'),
(12, 'solar wind', 'G2', '2025-03-18 16:10:00'),
(13, 'solar flare', 'G5', '2025-02-02 21:55:00'),
(14, 'CME', 'G1', '2025-01-25 02:40:00'),
(15, 'solar wind', 'G2', '2025-03-07 19:00:00');

INSERT INTO Magnetic_Readings (reading_id, sensor_id, timestamp, disturbance_level) VALUES
(1, 1, '2025-05-10 08:00:00', 120.5),
(2, 2, '2025-05-10 08:05:00', 115.3),
(3, 3, '2025-05-10 08:10:00', 110.7),
(4, 4, '2025-05-10 08:15:00', 108.9),
(5, 5, '2025-05-10 08:20:00', 130.2),
(6, 6, '2025-05-10 08:25:00', 125.4),
(7, 7, '2025-05-10 08:30:00', 122.1),
(8, 8, '2025-05-10 08:35:00', 118.0),
(9, 9, '2025-05-10 08:40:00', 117.2),
(10, 10, '2025-05-10 08:45:00', 114.8),
(11, 11, '2025-05-10 08:50:00', 116.9),
(12, 12, '2025-05-10 08:55:00', 119.3),
(13, 13, '2025-05-10 09:00:00', 121.0),
(14, 14, '2025-05-10 09:05:00', 113.5),
(15, 15, '2025-05-10 09:10:00', 111.6);

INSERT INTO Satellite_Alerts (alert_id, satellite_name, event_id, risk_level) VALUES
(1, 'GOES', 1, 'medium'),
(2, 'DSCOVR', 2, 'low'),
(3, 'GOES', 3, 'low'),
(4, 'DSCOVR', 4, 'high'),
(5, 'GOES', 5, 'critical'),
(6, 'DSCOVR', 6, 'low'),
(7, 'GOES', 7, 'medium'),
(8, 'DSCOVR', 8, 'high'),
(9, 'GOES', 9, 'low'),
(10, 'DSCOVR', 10, 'high'),
(11, 'GOES', 11, 'medium'),
(12, 'DSCOVR', 12, 'medium'),
(13, 'GOES', 13, 'critical'),
(14, 'DSCOVR', 14, 'low'),
(15, 'GOES', 15, 'medium');

INSERT INTO Ground_Impacts (impact_id, location, event_id, effects) VALUES
(1, 'California, USA', 1, 'power grid disruption'),
(2, 'Texas, USA', 2, 'radio disruption'),
(3, 'Florida, USA', 3, 'GPS disruption'),
(4, 'Ontario, Canada', 4, 'power grid disruption'),
(5, 'Berlin, Germany', 5, 'radio disruption'),
(6, 'Tokyo, Japan', 6, 'GPS disruption'),
(7, 'Delhi, India', 7, 'power grid disruption'),
(8, 'Karachi, Pakistan', 8, 'radio disruption'),
(9, 'Paris, France', 9, 'GPS disruption'),
(10, 'Rome, Italy', 10, 'power grid disruption'),
(11, 'Moscow, Russia', 11, 'radio disruption'),
(12, 'London, UK', 12, 'GPS disruption'),
(13, 'Beijing, China', 13, 'power grid disruption'),
(14, 'Cairo, Egypt', 14, 'radio disruption'),
(15, 'Rio de Janeiro, Brazil', 15, 'GPS disruption');

INSERT INTO Response_Protocols (protocol_id, trigger_condition, action, priority_level) VALUES
(1, 'G3 event detected', 'Notify control centers', 2),
(2, 'G4 event detected', 'Activate emergency protocols', 1),
(3, 'Solar flare > G2', 'Alert satellite operators', 3),
(4, 'Radio disruption reported', 'Switch frequencies', 2),
(5, 'GPS loss', 'Enable inertial navigation', 3),
(6, 'High disturbance level > 120', 'Calibrate sensors', 2),
(7, 'Power grid instability', 'Reduce load', 1),
(8, 'Radiation alert', 'Advise aircraft reroute', 1),
(9, 'CME detection', 'Isolate sensitive equipment', 2),
(10, 'High-priority alert from GOES', 'Initiate backup communication', 1),
(11, 'G5 intensity', 'Full lockdown of satellites', 1),
(12, 'Multiple sensor errors', 'Diagnostic test', 3),
(13, 'Low calibration score', 'Manual override', 3),
(14, 'Equipment failure', 'Notify maintenance team', 2),
(15, 'Historical storm match', 'Consult archival logs', 3);

INSERT INTO Historical_Geostorms (storm_id, year, estimated_strength, damage_cost) VALUES
(1, 1859, 'Carrington-class', 2000000000.00),
(2, 1921, 'Strong', 1500000000.00),
(3, 1989, 'Moderate', 500000000.00),
(4, 2000, 'Strong', 750000000.00),
(5, 2003, 'Extreme', 1200000000.00),
(6, 2012, 'Severe', 2500000000.00),
(7, 1994, 'Moderate', 300000000.00),
(8, 1991, 'Strong', 450000000.00),
(9, 2015, 'Weak', 150000000.00),
(10, 1972, 'Strong', 900000000.00),
(11, 1960, 'Moderate', 250000000.00),
(12, 2006, 'Weak', 180000000.00),
(13, 2017, 'Moderate', 400000000.00),
(14, 1997, 'Severe', 1000000000.00),
(15, 2021, 'Moderate', 550000000.00);

INSERT INTO Equipment (equipment_id, station_id, type, sitrep) VALUES
(1, 1, 'backup generator', 'operational'),
(2, 1, 'antenna', 'faulty'),
(3, 2, 'power inverter', 'operational'),
(4, 3, 'antenna', 'operational'),
(5, 4, 'backup generator', 'damaged'),
(6, 5, 'cooling system', 'operational'),
(7, 6, 'antenna', 'damaged'),
(8, 7, 'battery bank', 'operational'),
(9, 8, 'backup generator', 'faulty'),
(10, 9, 'antenna', 'operational'),
(11, 10, 'power inverter', 'damaged'),
(12, 11, 'cooling system', 'operational'),
(13, 12, 'battery bank', 'operational'),
(14, 13, 'antenna', 'operational'),
(15, 14, 'backup generator', 'faulty');

INSERT INTO Personnel (person_id, name, role, station_id) VALUES
(1, 'Dr. Sara Ali', 'meteorologist', 1),
(2, 'Engr. John Smith', 'engineer', 1),
(3, 'Dr. Maria Lin', 'meteorologist', 2),
(4, 'Engr. David Kim', 'engineer', 2),
(5, 'Dr. Zoe Chen', 'meteorologist', 3),
(6, 'Engr. Omar Hussain', 'engineer', 3),
(7, 'Dr. Elena Petrova', 'meteorologist', 4),
(8, 'Engr. Khalid Noor', 'engineer', 4),
(9, 'Dr. Alice Ray', 'meteorologist', 5),
(10, 'Engr. Faisal Khan', 'engineer', 5),
(11, 'Dr. Nora Patel', 'meteorologist', 6),
(12, 'Engr. Jamie Watts', 'engineer', 6),
(13, 'Dr. Adeel Raza', 'meteorologist', 7),
(14, 'Engr. Carla Diaz', 'engineer', 7),
(15, 'Dr. Hana Yoon', 'meteorologist', 8);
