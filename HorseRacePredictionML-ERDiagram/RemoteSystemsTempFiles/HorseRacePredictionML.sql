
/* Drop Indexes */

DROP INDEX IF EXISTS idx_registrationNumber;



/* Drop Tables */

DROP TABLE IF EXISTS race_horse_actual;
DROP TABLE IF EXISTS race_horse_info;
DROP TABLE IF EXISTS race_horse_result;
DROP TABLE IF EXISTS race_info;
DROP TABLE IF EXISTS holding_info;
DROP TABLE IF EXISTS horse_attribute;
DROP TABLE IF EXISTS jockery_attribute;
DROP TABLE IF EXISTS trainer_attribute;




/* Create Tables */

-- JRDB開催データ（KAB）より抽出
CREATE TABLE holding_info
(
	holding_id uuid NOT NULL UNIQUE,
	holding_fieldCode smallint NOT NULL,
	holding_year serial NOT NULL,
	holding_times smallint NOT NULL,
	holding_day smallint NOT NULL,
	holding_date date NOT NULL,
	CONSTRAINT holding_info_key UNIQUE (holding_id, holding_fieldCode, holding_year, holding_times, holding_day)
) WITHOUT OIDS;


-- JRDB登録馬データ（KTA）から抽出
CREATE TABLE horse_attribute
(
	registrationNumber varchar(8) NOT NULL UNIQUE,
	horseNameKey varchar(20) NOT NULL,
	horseName varchar(18) NOT NULL,
	sex smallint NOT NULL,
	horseClass smallint NOT NULL,
	color smallint NOT NULL,
	trainerCode smallint NOT NULL,
	turfSuitabilityCode smallint NOT NULL,
	dartSuitabilityCode smallint NOT NULL,
	heavySuitabilityCode smallint NOT NULL,
	PRIMARY KEY (registrationNumber)
) WITHOUT OIDS;


-- JRDB騎手データ（KZA）から抽出
CREATE TABLE jockery_attribute
(
	jockeyCode int NOT NULL UNIQUE,
	delete_flg smallint NOT NULL,
	delete_date date NOT NULL,
	jockerName varchar(6) NOT NULL,
	departmentCode smallint NOT NULL,
	birthday date NOT NULL,
	firstLicenseYear smallint NOT NULL,
	apprenticeClass smallint,
	trainerCode int,
	PRIMARY KEY (jockeyCode)
) WITHOUT OIDS;


-- JRDB競走馬拡張データ（KKA）から抽出
CREATE TABLE race_horse_actual
(
	holding_id uuid NOT NULL,
	race_number smallint NOT NULL,
	gateNumber smallint NOT NULL,
	registrationNumber varchar(8) NOT NULL,
	jra_record_1 smallint NOT NULL,
	jra_record_2 smallint NOT NULL,
	jra_record_3 smallint NOT NULL,
	jra_record_4 smallint,
	ac_record_1 smallint NOT NULL,
	ac_record_2 smallint NOT NULL,
	ac_record_3 smallint NOT NULL,
	ac_record_4 smallint NOT NULL,
	other_record_1 smallint NOT NULL,
	other_record_2 smallint NOT NULL,
	other_record_3 smallint NOT NULL,
	other_record_4 smallint NOT NULL,
	horse_track_type_record_1 smallint NOT NULL,
	horse_track_type_record_2 smallint NOT NULL,
	horse_track_type_record_3 smallint NOT NULL,
	horse_track_type_record_4 smallint NOT NULL,
	horse_track_type_distance_record_1 smallint NOT NULL,
	horse_track_type_distance_record_2 smallint NOT NULL,
	horse_track_type_distance_record_3 smallint NOT NULL,
	horse_track_type_distance_record_4 smallint NOT NULL,
	horse_track_distance_record_1 smallint NOT NULL,
	horse_track_distance_record_2 smallint NOT NULL,
	horse_track_distance_record_3 smallint NOT NULL,
	horse_track_distance_record_4 smallint NOT NULL,
	horse_rotation_record_1 smallint NOT NULL,
	horse_rotation_record_2 smallint NOT NULL,
	horse_rotation_record_3 smallint NOT NULL,
	horse_rotation_record_4 smallint NOT NULL,
	horse_direction_record_1 smallint NOT NULL,
	horse_direction_record_2 smallint NOT NULL,
	horse_direction_record_3 smallint NOT NULL,
	horse_direction_record_4 smallint NOT NULL,
	horse_jockey_record_1 smallint NOT NULL,
	horse_jockey_record_2 smallint NOT NULL,
	horse_jockey_record_3 smallint NOT NULL,
	horse_jockey_record_4 smallint NOT NULL,
	horse_course_good_record_1 smallint NOT NULL,
	horse_course_good_record_2 smallint NOT NULL,
	horse_course_good_record_3 smallint NOT NULL,
	horse_course_good_record_4 smallint NOT NULL,
	horse_course_slightly_heavy_record_1 smallint NOT NULL,
	horse_course_slightly_heavy_record_2 smallint NOT NULL,
	horse_course_slightly_heavy_record_3 smallint NOT NULL,
	horse_course_slightly_heavy_record_4 smallint NOT NULL,
	horse_course_heavy_record_1 smallint NOT NULL,
	horse_course_heavy_record_2 smallint NOT NULL,
	horse_course_heavy_record_3 smallint NOT NULL,
	horse_course_heavy_record_4 smallint NOT NULL,
	horse_pace_s_record_1 smallint NOT NULL,
	horse_pace_s_record_2 smallint NOT NULL,
	horse_pace_s_record_3 smallint NOT NULL,
	horse_pace_s_record_4 smallint NOT NULL,
	horse_pace_m_record_1 smallint NOT NULL,
	horse_pace_m_record_2 smallint NOT NULL,
	horse_pace_m_record_3 smallint NOT NULL,
	horse_pace_m_record_4 smallint NOT NULL,
	horse_pace_h_record_1 smallint NOT NULL,
	horse_pace_h_record_2 smallint NOT NULL,
	horse_pace_h_record_3 smallint NOT NULL,
	horse_pace_h_record_4 smallint NOT NULL,
	jokey_distance_record_1 smallint NOT NULL,
	jokey_distance_record_2 smallint NOT NULL,
	jokey_distance_record_3 smallint NOT NULL,
	jokey_distance_record_4 smallint NOT NULL,
	jokey_track_distance_record_1 smallint NOT NULL,
	jokey_track_distance_record_2 smallint NOT NULL,
	jokey_track_distance_record_3 smallint NOT NULL,
	jokey_track_distance_record_4 smallint NOT NULL,
	father_turf_ratio real NOT NULL,
	father_dart_ratio real NOT NULL,
	father_avg_distance smallint NOT NULL,
	grandfather_turf_ratio real NOT NULL,
	grandfather_dart_ratio real NOT NULL,
	grandfather_avg_distance smallint NOT NULL,
	CONSTRAINT race_horse_actual_key UNIQUE (holding_id, race_number, gateNumber)
) WITHOUT OIDS;


-- JRDB競走馬データ（KYI）から抽出
CREATE TABLE race_horse_info
(
	holding_id uuid NOT NULL,
	race_number smallint NOT NULL,
	gateNumber smallint NOT NULL,
	registrationNumber varchar(8) NOT NULL,
	horseWeight smallint NOT NULL,
	horseWeightGain smallint NOT NULL,
	weight smallint NOT NULL,
	jockeyCode int NOT NULL,
	trainerCode int NOT NULL,
	CONSTRAINT race_horse_info_key UNIQUE (holding_id, race_number, gateNumber)
) WITHOUT OIDS;


-- JRDB成績データ（SED）より抽出
CREATE TABLE race_horse_result
(
	holding_id uuid NOT NULL,
	race_number smallint NOT NULL,
	gateNumber smallint NOT NULL,
	registrationNumber varchar(8) NOT NULL,
	raceOrder smallint NOT NULL,
	raceTime smallint NOT NULL,
	abnormality smallint NOT NULL,
	winningOdds real NOT NULL,
	winningRank smallint NOT NULL,
	corner_order1 smallint,
	corner_order2 smallint,
	corner_order3 smallint,
	corner_order4 smallint,
	course smallint,
	legQuality smallint,
	incomePrize smallint NOT NULL,
	lastCournerPosition smallint,
	first3ftime smallint NOT NULL,
	last3ftime smallint NOT NULL,
	firstHorse_name varchar(6) NOT NULL,
	firstHorse_lateTime smallint NOT NULL,
	CONSTRAINT race_horse_result_key UNIQUE (holding_id, race_number, gateNumber)
) WITHOUT OIDS;


-- JRDB番組データ（BAC）より抽出
CREATE TABLE race_info
(
	holding_id uuid NOT NULL,
	race_number smallint NOT NULL,
	term_distance smallint NOT NULL,
	-- 芝ダ障害コード 
	term_trackType smallint NOT NULL,
	term_trackDirection smallint NOT NULL,
	term_trackSide smallint NOT NULL,
	term_condition smallint NOT NULL,
	term_type smallint NOT NULL,
	term_class varchar(2),
	term_symbol smallint NOT NULL,
	term_weight smallint,
	term_grade smallint NOT NULL,
	term_raceName varchar(25) NOT NULL,
	term_number smallint NOT NULL,
	CONSTRAINT race_info_key UNIQUE (holding_id, race_number)
) WITHOUT OIDS;


-- JRDB調教師データ（CZA）より抽出
CREATE TABLE trainer_attribute
(
	trainerCode int NOT NULL UNIQUE,
	delete_flg smallint NOT NULL,
	delete_date date,
	trainer_name varchar(6) NOT NULL,
	departmentCode smallint NOT NULL,
	birthday date NOT NULL,
	firstLicenseYear smallint NOT NULL,
	PRIMARY KEY (trainerCode)
) WITHOUT OIDS;



/* Create Foreign Keys */

ALTER TABLE race_horse_actual
	ADD FOREIGN KEY (holding_id)
	REFERENCES holding_info (holding_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE race_horse_info
	ADD FOREIGN KEY (holding_id)
	REFERENCES holding_info (holding_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE race_horse_result
	ADD FOREIGN KEY (holding_id)
	REFERENCES holding_info (holding_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE race_info
	ADD FOREIGN KEY (holding_id)
	REFERENCES holding_info (holding_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE race_horse_actual
	ADD FOREIGN KEY (registrationNumber)
	REFERENCES horse_attribute (registrationNumber)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE race_horse_info
	ADD FOREIGN KEY (registrationNumber)
	REFERENCES horse_attribute (registrationNumber)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE race_horse_result
	ADD FOREIGN KEY (registrationNumber)
	REFERENCES horse_attribute (registrationNumber)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE race_horse_info
	ADD FOREIGN KEY (jockeyCode)
	REFERENCES jockery_attribute (jockeyCode)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE race_horse_info
	ADD FOREIGN KEY (trainerCode)
	REFERENCES trainer_attribute (trainerCode)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



/* Create Indexes */

CREATE INDEX idx_registrationNumber ON race_horse_result USING BTREE (registrationNumber);



/* Comments */

COMMENT ON TABLE holding_info IS 'JRDB開催データ（KAB）より抽出';
COMMENT ON TABLE horse_attribute IS 'JRDB登録馬データ（KTA）から抽出';
COMMENT ON TABLE jockery_attribute IS 'JRDB騎手データ（KZA）から抽出';
COMMENT ON TABLE race_horse_actual IS 'JRDB競走馬拡張データ（KKA）から抽出';
COMMENT ON TABLE race_horse_info IS 'JRDB競走馬データ（KYI）から抽出';
COMMENT ON TABLE race_horse_result IS 'JRDB成績データ（SED）より抽出';
COMMENT ON TABLE race_info IS 'JRDB番組データ（BAC）より抽出';
COMMENT ON COLUMN race_info.term_trackType IS '芝ダ障害コード ';
COMMENT ON TABLE trainer_attribute IS 'JRDB調教師データ（CZA）より抽出';



