library "All"
using FHIR version '4.0.0'
include FHIRHelpers version '4.0.0'

codesystem icd10: 'http://fhir.de/CodeSystem/bfarm/icd-10-gm'
codesystem loinc: 'http://loinc.org'
codesystem oops: 'http://fhir.de/CodeSystem/bfarm/ops'
codesystem consent_policy: 'urn:oid:2.16.840.1.113883.3.1937.777.24.5.3'
codesystem atc: 'http://fhir.de/CodeSystem/bfarm/atc'
codesystem snomed: 'http://snomed.info/sct'

context Unfiltered

define AcarboseA10BF01Ref:
  from [Medication: Code 'A10BF01' from atc] M
    return 'Medication/' + M.id

define AcetohexamidA10BB31Ref:
  from [Medication: Code 'A10BB31' from atc] M
    return 'Medication/' + M.id

define AlbiglutidA10BJ04Ref:
  from [Medication: Code 'A10BJ04' from atc] M
    return 'Medication/' + M.id

define AldosereduktasehemmerA10XARef:
  from [Medication: Code 'A10XA' from atc] M
    return 'Medication/' + M.id

define AlogliptinA10BH04Ref:
  from [Medication: Code 'A10BH04' from atc] M
    return 'Medication/' + M.id

define "Alpha-GlukosidasehemmerA10BFRef":
  from [Medication: Code 'A10BF' from atc] M
    return 'Medication/' + M.id

define "Andere Antidiabetika, exkl. InsulineA10BXRef":
  from [Medication: Code 'A10BX' from atc] M
    return 'Medication/' + M.id

define "Andere AntidiabetikaA10XRef":
  from [Medication: Code 'A10X' from atc] M
    return 'Medication/' + M.id

define "Antidiabetika, Exkl. InsulineA10BRef":
  from [Medication: Code 'A10B' from atc] M
    return 'Medication/' + M.id

define AntidiabetikaA10Ref:
  from [Medication: Code 'A10' from atc] M
    return 'Medication/' + M.id

define BeinaglutidA10BJ07Ref:
  from [Medication: Code 'A10BJ07' from atc] M
    return 'Medication/' + M.id

define BenfluorexA10BX06Ref:
  from [Medication: Code 'A10BX06' from atc] M
    return 'Medication/' + M.id

define BiguanideA10BARef:
  from [Medication: Code 'A10BA' from atc] M
    return 'Medication/' + M.id

define BuforminA10BA03Ref:
  from [Medication: Code 'A10BA03' from atc] M
    return 'Medication/' + M.id

define CanagliflozinA10BK02Ref:
  from [Medication: Code 'A10BK02' from atc] M
    return 'Medication/' + M.id

define CarbutamidA10BB06Ref:
  from [Medication: Code 'A10BB06' from atc] M
    return 'Medication/' + M.id

define ChlorpropamidA10BB02Ref:
  from [Medication: Code 'A10BB02' from atc] M
    return 'Medication/' + M.id

define CopalchirindenextraktA10XP02Ref:
  from [Medication: Code 'A10XP02' from atc] M
    return 'Medication/' + M.id

define DapagliflozinA10BK01Ref:
  from [Medication: Code 'A10BK01' from atc] M
    return 'Medication/' + M.id

define "Dipeptidyl-Peptidase-4-(DPP-4)-InhibitorenA10BHRef":
  from [Medication: Code 'A10BH' from atc] M
    return 'Medication/' + M.id

define DulaglutidA10BJ05Ref:
  from [Medication: Code 'A10BJ05' from atc] M
    return 'Medication/' + M.id

define EmpagliflozinA10BK03Ref:
  from [Medication: Code 'A10BK03' from atc] M
    return 'Medication/' + M.id

define ErtugliflozinA10BK04Ref:
  from [Medication: Code 'A10BK04' from atc] M
    return 'Medication/' + M.id

define EvogliptinA10BH07Ref:
  from [Medication: Code 'A10BH07' from atc] M
    return 'Medication/' + M.id

define ExenatidA10BJ01Ref:
  from [Medication: Code 'A10BJ01' from atc] M
    return 'Medication/' + M.id

define "Gemigliptin und RosuvastatinA10BH52Ref":
  from [Medication: Code 'A10BH52' from atc] M
    return 'Medication/' + M.id

define GemigliptinA10BH06Ref:
  from [Medication: Code 'A10BH06' from atc] M
    return 'Medication/' + M.id

define GlibenclamidA10BB01Ref:
  from [Medication: Code 'A10BB01' from atc] M
    return 'Medication/' + M.id

define GlibornuridA10BB04Ref:
  from [Medication: Code 'A10BB04' from atc] M
    return 'Medication/' + M.id

define GliclazidA10BB09Ref:
  from [Medication: Code 'A10BB09' from atc] M
    return 'Medication/' + M.id

define "Glimepirid und PioglitazonA10BD06Ref":
  from [Medication: Code 'A10BD06' from atc] M
    return 'Medication/' + M.id

define "Glimepirid und RosiglitazonA10BD04Ref":
  from [Medication: Code 'A10BD04' from atc] M
    return 'Medication/' + M.id

define GlimepiridA10BB12Ref:
  from [Medication: Code 'A10BB12' from atc] M
    return 'Medication/' + M.id

define GlipizidA10BB07Ref:
  from [Medication: Code 'A10BB07' from atc] M
    return 'Medication/' + M.id

define GliquidonA10BB08Ref:
  from [Medication: Code 'A10BB08' from atc] M
    return 'Medication/' + M.id

define GlisoxepidA10BB11Ref:
  from [Medication: Code 'A10BB11' from atc] M
    return 'Medication/' + M.id

define "Glucagon-like-Peptid-1-(GLP-1)-RezeptoragonistenA10BJRef":
  from [Medication: Code 'A10BJ' from atc] M
    return 'Medication/' + M.id

define GlymidinA10BC01Ref:
  from [Medication: Code 'A10BC01' from atc] M
    return 'Medication/' + M.id

define "Guar-Mehl*A10BX01Ref":
  from [Medication: Code 'A10BX01' from atc] M
    return 'Medication/' + M.id

define "Guar-MehlA10XP01Ref":
  from [Medication: Code 'A10XP01' from atc] M
    return 'Medication/' + M.id

define "Homöopathische und anthroposophische AntidiabetikaA10XHRef":
  from [Medication: Code 'A10XH' from atc] M
    return 'Medication/' + M.id

define ImegliminA10BX15Ref:
  from [Medication: Code 'A10BX15' from atc] M
    return 'Medication/' + M.id

define "Insulin (Rind)A10AB02Ref":
  from [Medication: Code 'A10AB02' from atc] M
    return 'Medication/' + M.id

define "Insulin (Rind)A10AC02Ref":
  from [Medication: Code 'A10AC02' from atc] M
    return 'Medication/' + M.id

define "Insulin (Rind)A10AD02Ref":
  from [Medication: Code 'A10AD02' from atc] M
    return 'Medication/' + M.id

define "Insulin (Rind)A10AE02Ref":
  from [Medication: Code 'A10AE02' from atc] M
    return 'Medication/' + M.id

define "Insulin (Schwein)A10AB03Ref":
  from [Medication: Code 'A10AB03' from atc] M
    return 'Medication/' + M.id

define "Insulin (Schwein)A10AC03Ref":
  from [Medication: Code 'A10AC03' from atc] M
    return 'Medication/' + M.id

define "Insulin (Schwein)A10AD03Ref":
  from [Medication: Code 'A10AD03' from atc] M
    return 'Medication/' + M.id

define "Insulin (Schwein)A10AE03Ref":
  from [Medication: Code 'A10AE03' from atc] M
    return 'Medication/' + M.id

define "Insulin (human)A10AB01Ref":
  from [Medication: Code 'A10AB01' from atc] M
    return 'Medication/' + M.id

define "Insulin (human)A10AC01Ref":
  from [Medication: Code 'A10AC01' from atc] M
    return 'Medication/' + M.id

define "Insulin (human)A10AD01Ref":
  from [Medication: Code 'A10AD01' from atc] M
    return 'Medication/' + M.id

define "Insulin (human)A10AE01Ref":
  from [Medication: Code 'A10AE01' from atc] M
    return 'Medication/' + M.id

define "Insulin (human)A10AF01Ref":
  from [Medication: Code 'A10AF01' from atc] M
    return 'Medication/' + M.id

define "Insulin aspartA10AB05Ref":
  from [Medication: Code 'A10AB05' from atc] M
    return 'Medication/' + M.id

define "Insulin aspartA10AD05Ref":
  from [Medication: Code 'A10AD05' from atc] M
    return 'Medication/' + M.id

define "Insulin degludec und Insulin aspartA10AD06Ref":
  from [Medication: Code 'A10AD06' from atc] M
    return 'Medication/' + M.id

define "Insulin degludec und LiraglutidA10AE56Ref":
  from [Medication: Code 'A10AE56' from atc] M
    return 'Medication/' + M.id

define "Insulin degludecA10AE06Ref":
  from [Medication: Code 'A10AE06' from atc] M
    return 'Medication/' + M.id

define "Insulin detemirA10AE05Ref":
  from [Medication: Code 'A10AE05' from atc] M
    return 'Medication/' + M.id

define "Insulin glargin und LixisenatidA10AE54Ref":
  from [Medication: Code 'A10AE54' from atc] M
    return 'Medication/' + M.id

define "Insulin glarginA10AE04Ref":
  from [Medication: Code 'A10AE04' from atc] M
    return 'Medication/' + M.id

define "Insulin glulisinA10AB06Ref":
  from [Medication: Code 'A10AB06' from atc] M
    return 'Medication/' + M.id

define "Insulin lisproA10AB04Ref":
  from [Medication: Code 'A10AB04' from atc] M
    return 'Medication/' + M.id

define "Insulin lisproA10AC04Ref":
  from [Medication: Code 'A10AC04' from atc] M
    return 'Medication/' + M.id

define "Insulin lisproA10AD04Ref":
  from [Medication: Code 'A10AD04' from atc] M
    return 'Medication/' + M.id

define "Insuline Und AnalogaA10ARef":
  from [Medication: Code 'A10A' from atc] M
    return 'Medication/' + M.id

define "Insuline und Analoga zur InhalationA10AFRef":
  from [Medication: Code 'A10AF' from atc] M
    return 'Medication/' + M.id

define "Insuline und Analoga zur Injektion, intermediär oder lang wirkend kombiniert mit schnell wirkendA10ADRef":
  from [Medication: Code 'A10AD' from atc] M
    return 'Medication/' + M.id

define "Insuline und Analoga zur Injektion, intermediär wirkendA10ACRef":
  from [Medication: Code 'A10AC' from atc] M
    return 'Medication/' + M.id

define "Insuline und Analoga zur Injektion, lang wirkendA10AERef":
  from [Medication: Code 'A10AE' from atc] M
    return 'Medication/' + M.id

define "Insuline und Analoga zur Injektion, schnell wirkendA10ABRef":
  from [Medication: Code 'A10AB' from atc] M
    return 'Medication/' + M.id

define IpragliflozinA10BK05Ref:
  from [Medication: Code 'A10BK05' from atc] M
    return 'Medication/' + M.id

define "Kombinationen oraler AntidiabetikaA10BDRef":
  from [Medication: Code 'A10BD' from atc] M
    return 'Medication/' + M.id

define KombinationenA10AB30Ref:
  from [Medication: Code 'A10AB30' from atc] M
    return 'Medication/' + M.id

define KombinationenA10AC30Ref:
  from [Medication: Code 'A10AC30' from atc] M
    return 'Medication/' + M.id

define KombinationenA10AD30Ref:
  from [Medication: Code 'A10AD30' from atc] M
    return 'Medication/' + M.id

define KombinationenA10AE30Ref:
  from [Medication: Code 'A10AE30' from atc] M
    return 'Medication/' + M.id

define KombinationenA10XH20Ref:
  from [Medication: Code 'A10XH20' from atc] M
    return 'Medication/' + M.id

define KombinationenA10XP30Ref:
  from [Medication: Code 'A10XP30' from atc] M
    return 'Medication/' + M.id

define "Linagliptin und EmpagliflozinA10BD19Ref":
  from [Medication: Code 'A10BD19' from atc] M
    return 'Medication/' + M.id

define LinagliptinA10BH05Ref:
  from [Medication: Code 'A10BH05' from atc] M
    return 'Medication/' + M.id

define LiraglutidA10BJ02Ref:
  from [Medication: Code 'A10BJ02' from atc] M
    return 'Medication/' + M.id

define LixisenatidA10BJ03Ref:
  from [Medication: Code 'A10BJ03' from atc] M
    return 'Medication/' + M.id

define LobeglitazonA10BG04Ref:
  from [Medication: Code 'A10BG04' from atc] M
    return 'Medication/' + M.id

define LuseogliflozinA10BK07Ref:
  from [Medication: Code 'A10BK07' from atc] M
    return 'Medication/' + M.id

define MetahexamidA10BB10Ref:
  from [Medication: Code 'A10BB10' from atc] M
    return 'Medication/' + M.id

define "Metformin und AcarboseA10BD17Ref":
  from [Medication: Code 'A10BD17' from atc] M
    return 'Medication/' + M.id

define "Metformin und AlogliptinA10BD13Ref":
  from [Medication: Code 'A10BD13' from atc] M
    return 'Medication/' + M.id

define "Metformin und CanagliflozinA10BD16Ref":
  from [Medication: Code 'A10BD16' from atc] M
    return 'Medication/' + M.id

define "Metformin und DapagliflozinA10BD15Ref":
  from [Medication: Code 'A10BD15' from atc] M
    return 'Medication/' + M.id

define "Metformin und EmpagliflozinA10BD20Ref":
  from [Medication: Code 'A10BD20' from atc] M
    return 'Medication/' + M.id

define "Metformin und ErtugliflozinA10BD23Ref":
  from [Medication: Code 'A10BD23' from atc] M
    return 'Medication/' + M.id

define "Metformin und EvogliptinA10BD22Ref":
  from [Medication: Code 'A10BD22' from atc] M
    return 'Medication/' + M.id

define "Metformin und GemigliptinA10BD18Ref":
  from [Medication: Code 'A10BD18' from atc] M
    return 'Medication/' + M.id

define "Metformin und GlibenclamidA10BD31Ref":
  from [Medication: Code 'A10BD31' from atc] M
    return 'Medication/' + M.id

define "Metformin und LinagliptinA10BD11Ref":
  from [Medication: Code 'A10BD11' from atc] M
    return 'Medication/' + M.id

define "Metformin und LobeglitazonA10BD26Ref":
  from [Medication: Code 'A10BD26' from atc] M
    return 'Medication/' + M.id

define "Metformin und PioglitazonA10BD05Ref":
  from [Medication: Code 'A10BD05' from atc] M
    return 'Medication/' + M.id

define "Metformin und RepaglinidA10BD14Ref":
  from [Medication: Code 'A10BD14' from atc] M
    return 'Medication/' + M.id

define "Metformin und RosiglitazonA10BD03Ref":
  from [Medication: Code 'A10BD03' from atc] M
    return 'Medication/' + M.id

define "Metformin und SaxagliptinA10BD10Ref":
  from [Medication: Code 'A10BD10' from atc] M
    return 'Medication/' + M.id

define "Metformin und SitagliptinA10BD07Ref":
  from [Medication: Code 'A10BD07' from atc] M
    return 'Medication/' + M.id

define "Metformin und SulfonylharnstoffeA10BD02Ref":
  from [Medication: Code 'A10BD02' from atc] M
    return 'Medication/' + M.id

define "Metformin und VildagliptinA10BD08Ref":
  from [Medication: Code 'A10BD08' from atc] M
    return 'Medication/' + M.id

define "Metformin, Linagliptin und EmpagliflozinA10BD27Ref":
  from [Medication: Code 'A10BD27' from atc] M
    return 'Medication/' + M.id

define "Metformin, Saxagliptin und DapagliflozinA10BD25Ref":
  from [Medication: Code 'A10BD25' from atc] M
    return 'Medication/' + M.id

define MetforminA10BA02Ref:
  from [Medication: Code 'A10BA02' from atc] M
    return 'Medication/' + M.id

define MiglitolA10BF02Ref:
  from [Medication: Code 'A10BF02' from atc] M
    return 'Medication/' + M.id

define MitiglinidA10BX08Ref:
  from [Medication: Code 'A10BX08' from atc] M
    return 'Medication/' + M.id

define NateglinidA10BX03Ref:
  from [Medication: Code 'A10BX03' from atc] M
    return 'Medication/' + M.id

define "Natrium-Glucose-Cotransporter-2-(SGLT2)-InhibitorenA10BKRef":
  from [Medication: Code 'A10BK' from atc] M
    return 'Medication/' + M.id

define "Pflanzliche AntidiabetikaA10XPRef":
  from [Medication: Code 'A10XP' from atc] M
    return 'Medication/' + M.id

define "Phenformin und SulfonylharnstoffeA10BD01Ref":
  from [Medication: Code 'A10BD01' from atc] M
    return 'Medication/' + M.id

define PhenforminA10BA01Ref:
  from [Medication: Code 'A10BA01' from atc] M
    return 'Medication/' + M.id

define "Pioglitazon und AlogliptinA10BD09Ref":
  from [Medication: Code 'A10BD09' from atc] M
    return 'Medication/' + M.id

define "Pioglitazon und SitagliptinA10BD12Ref":
  from [Medication: Code 'A10BD12' from atc] M
    return 'Medication/' + M.id

define PioglitazonA10BG03Ref:
  from [Medication: Code 'A10BG03' from atc] M
    return 'Medication/' + M.id

define PramlintidA10BX05Ref:
  from [Medication: Code 'A10BX05' from atc] M
    return 'Medication/' + M.id

define RepaglinidA10BX02Ref:
  from [Medication: Code 'A10BX02' from atc] M
    return 'Medication/' + M.id

define RosiglitazonA10BG02Ref:
  from [Medication: Code 'A10BG02' from atc] M
    return 'Medication/' + M.id

define "Saxagliptin und DapagliflozinA10BD21Ref":
  from [Medication: Code 'A10BD21' from atc] M
    return 'Medication/' + M.id

define SaxagliptinA10BH03Ref:
  from [Medication: Code 'A10BH03' from atc] M
    return 'Medication/' + M.id

define SemaglutidA10BJ06Ref:
  from [Medication: Code 'A10BJ06' from atc] M
    return 'Medication/' + M.id

define "Sitagliptin und ErtugliflozinA10BD24Ref":
  from [Medication: Code 'A10BD24' from atc] M
    return 'Medication/' + M.id

define "Sitagliptin und SimvastatinA10BH51Ref":
  from [Medication: Code 'A10BH51' from atc] M
    return 'Medication/' + M.id

define SitagliptinA10BH01Ref:
  from [Medication: Code 'A10BH01' from atc] M
    return 'Medication/' + M.id

define SotagliflozinA10BK06Ref:
  from [Medication: Code 'A10BK06' from atc] M
    return 'Medication/' + M.id

define "Sulfonamide (heterozyklisch)A10BCRef":
  from [Medication: Code 'A10BC' from atc] M
    return 'Medication/' + M.id

define SulfonylharnstoffeA10BBRef:
  from [Medication: Code 'A10BB' from atc] M
    return 'Medication/' + M.id

define TeneligliptinA10BH08Ref:
  from [Medication: Code 'A10BH08' from atc] M
    return 'Medication/' + M.id

define "Thiazolidindione (Glitazone)A10BGRef":
  from [Medication: Code 'A10BG' from atc] M
    return 'Medication/' + M.id

define TolazamidA10BB05Ref:
  from [Medication: Code 'A10BB05' from atc] M
    return 'Medication/' + M.id

define TolbutamidA10BB03Ref:
  from [Medication: Code 'A10BB03' from atc] M
    return 'Medication/' + M.id

define TolrestatA10XA01Ref:
  from [Medication: Code 'A10XA01' from atc] M
    return 'Medication/' + M.id

define TroglitazonA10BG01Ref:
  from [Medication: Code 'A10BG01' from atc] M
    return 'Medication/' + M.id

define VildagliptinA10BH02Ref:
  from [Medication: Code 'A10BH02' from atc] M
    return 'Medication/' + M.id

define VogliboseA10BF03Ref:
  from [Medication: Code 'A10BF03' from atc] M
    return 'Medication/' + M.id

context Patient

define "1-Patient":
  Patient.gender = 'female' or
  Patient.gender = 'male'

define "2-Condition":
  exists [Condition: Code 'E10-E14' from icd10] or
  exists [Condition: Code 'E12' from icd10] or
  exists [Condition: Code 'E12.3' from icd10] or
  exists [Condition: Code 'E12.31' from icd10] or
  exists [Condition: Code 'E12.30' from icd10] or
  exists [Condition: Code 'E12.1' from icd10] or
  exists [Condition: Code 'E12.11' from icd10] or
  exists [Condition: Code 'E12.0' from icd10] or
  exists [Condition: Code 'E12.01' from icd10] or
  exists [Condition: Code 'E12.7' from icd10] or
  exists [Condition: Code 'E12.75' from icd10] or
  exists [Condition: Code 'E12.74' from icd10] or
  exists [Condition: Code 'E12.73' from icd10] or
  exists [Condition: Code 'E12.72' from icd10] or
  exists [Condition: Code 'E12.4' from icd10] or
  exists [Condition: Code 'E12.41' from icd10] or
  exists [Condition: Code 'E12.40' from icd10] or
  exists [Condition: Code 'E12.8' from icd10] or
  exists [Condition: Code 'E12.81' from icd10] or
  exists [Condition: Code 'E12.80' from icd10] or
  exists [Condition: Code 'E12.2' from icd10] or
  exists [Condition: Code 'E12.21' from icd10] or
  exists [Condition: Code 'E12.20' from icd10] or
  exists [Condition: Code 'E12.5' from icd10] or
  exists [Condition: Code 'E12.51' from icd10] or
  exists [Condition: Code 'E12.50' from icd10] or
  exists [Condition: Code 'E12.6' from icd10] or
  exists [Condition: Code 'E12.61' from icd10] or
  exists [Condition: Code 'E12.60' from icd10] or
  exists [Condition: Code 'E12.9' from icd10] or
  exists [Condition: Code 'E12.91' from icd10] or
  exists [Condition: Code 'E12.90' from icd10] or
  exists [Condition: Code 'E10' from icd10] or
  exists [Condition: Code 'E10.3' from icd10] or
  exists [Condition: Code 'E10.31' from icd10] or
  exists [Condition: Code 'E10.30' from icd10] or
  exists [Condition: Code 'E10.1' from icd10] or
  exists [Condition: Code 'E10.11' from icd10] or
  exists [Condition: Code 'E10.0' from icd10] or
  exists [Condition: Code 'E10.01' from icd10] or
  exists [Condition: Code 'E10.7' from icd10] or
  exists [Condition: Code 'E10.75' from icd10] or
  exists [Condition: Code 'E10.74' from icd10] or
  exists [Condition: Code 'E10.73' from icd10] or
  exists [Condition: Code 'E10.72' from icd10] or
  exists [Condition: Code 'E10.4' from icd10] or
  exists [Condition: Code 'E10.41' from icd10] or
  exists [Condition: Code 'E10.40' from icd10] or
  exists [Condition: Code 'E10.8' from icd10] or
  exists [Condition: Code 'E10.81' from icd10] or
  exists [Condition: Code 'E10.80' from icd10] or
  exists [Condition: Code 'E10.2' from icd10] or
  exists [Condition: Code 'E10.21' from icd10] or
  exists [Condition: Code 'E10.20' from icd10] or
  exists [Condition: Code 'E10.5' from icd10] or
  exists [Condition: Code 'E10.51' from icd10] or
  exists [Condition: Code 'E10.50' from icd10] or
  exists [Condition: Code 'E10.6' from icd10] or
  exists [Condition: Code 'E10.61' from icd10] or
  exists [Condition: Code 'E10.60' from icd10] or
  exists [Condition: Code 'E10.9' from icd10] or
  exists [Condition: Code 'E10.91' from icd10] or
  exists [Condition: Code 'E10.90' from icd10] or
  exists [Condition: Code 'E11' from icd10] or
  exists [Condition: Code 'E11.3' from icd10] or
  exists [Condition: Code 'E11.31' from icd10] or
  exists [Condition: Code 'E11.30' from icd10] or
  exists [Condition: Code 'E11.1' from icd10] or
  exists [Condition: Code 'E11.11' from icd10] or
  exists [Condition: Code 'E11.0' from icd10] or
  exists [Condition: Code 'E11.01' from icd10] or
  exists [Condition: Code 'E11.7' from icd10] or
  exists [Condition: Code 'E11.75' from icd10] or
  exists [Condition: Code 'E11.74' from icd10] or
  exists [Condition: Code 'E11.73' from icd10] or
  exists [Condition: Code 'E11.72' from icd10] or
  exists [Condition: Code 'E11.4' from icd10] or
  exists [Condition: Code 'E11.41' from icd10] or
  exists [Condition: Code 'E11.40' from icd10] or
  exists [Condition: Code 'E11.8' from icd10] or
  exists [Condition: Code 'E11.81' from icd10] or
  exists [Condition: Code 'E11.80' from icd10] or
  exists [Condition: Code 'E11.2' from icd10] or
  exists [Condition: Code 'E11.21' from icd10] or
  exists [Condition: Code 'E11.20' from icd10] or
  exists [Condition: Code 'E11.5' from icd10] or
  exists [Condition: Code 'E11.51' from icd10] or
  exists [Condition: Code 'E11.50' from icd10] or
  exists [Condition: Code 'E11.6' from icd10] or
  exists [Condition: Code 'E11.61' from icd10] or
  exists [Condition: Code 'E11.60' from icd10] or
  exists [Condition: Code 'E11.9' from icd10] or
  exists [Condition: Code 'E11.91' from icd10] or
  exists [Condition: Code 'E11.90' from icd10] or
  exists [Condition: Code 'E14' from icd10] or
  exists [Condition: Code 'E14.3' from icd10] or
  exists [Condition: Code 'E14.31' from icd10] or
  exists [Condition: Code 'E14.30' from icd10] or
  exists [Condition: Code 'E14.1' from icd10] or
  exists [Condition: Code 'E14.11' from icd10] or
  exists [Condition: Code 'E14.0' from icd10] or
  exists [Condition: Code 'E14.01' from icd10] or
  exists [Condition: Code 'E14.7' from icd10] or
  exists [Condition: Code 'E14.75' from icd10] or
  exists [Condition: Code 'E14.74' from icd10] or
  exists [Condition: Code 'E14.73' from icd10] or
  exists [Condition: Code 'E14.72' from icd10] or
  exists [Condition: Code 'E14.4' from icd10] or
  exists [Condition: Code 'E14.41' from icd10] or
  exists [Condition: Code 'E14.40' from icd10] or
  exists [Condition: Code 'E14.8' from icd10] or
  exists [Condition: Code 'E14.81' from icd10] or
  exists [Condition: Code 'E14.80' from icd10] or
  exists [Condition: Code 'E14.2' from icd10] or
  exists [Condition: Code 'E14.21' from icd10] or
  exists [Condition: Code 'E14.20' from icd10] or
  exists [Condition: Code 'E14.5' from icd10] or
  exists [Condition: Code 'E14.51' from icd10] or
  exists [Condition: Code 'E14.50' from icd10] or
  exists [Condition: Code 'E14.6' from icd10] or
  exists [Condition: Code 'E14.61' from icd10] or
  exists [Condition: Code 'E14.60' from icd10] or
  exists [Condition: Code 'E14.9' from icd10] or
  exists [Condition: Code 'E14.91' from icd10] or
  exists [Condition: Code 'E14.90' from icd10] or
  exists [Condition: Code 'E13' from icd10] or
  exists [Condition: Code 'E13.3' from icd10] or
  exists [Condition: Code 'E13.31' from icd10] or
  exists [Condition: Code 'E13.30' from icd10] or
  exists [Condition: Code 'E13.1' from icd10] or
  exists [Condition: Code 'E13.11' from icd10] or
  exists [Condition: Code 'E13.0' from icd10] or
  exists [Condition: Code 'E13.01' from icd10] or
  exists [Condition: Code 'E13.7' from icd10] or
  exists [Condition: Code 'E13.75' from icd10] or
  exists [Condition: Code 'E13.74' from icd10] or
  exists [Condition: Code 'E13.73' from icd10] or
  exists [Condition: Code 'E13.72' from icd10] or
  exists [Condition: Code 'E13.4' from icd10] or
  exists [Condition: Code 'E13.41' from icd10] or
  exists [Condition: Code 'E13.40' from icd10] or
  exists [Condition: Code 'E13.8' from icd10] or
  exists [Condition: Code 'E13.81' from icd10] or
  exists [Condition: Code 'E13.80' from icd10] or
  exists [Condition: Code 'E13.2' from icd10] or
  exists [Condition: Code 'E13.21' from icd10] or
  exists [Condition: Code 'E13.20' from icd10] or
  exists [Condition: Code 'E13.5' from icd10] or
  exists [Condition: Code 'E13.51' from icd10] or
  exists [Condition: Code 'E13.50' from icd10] or
  exists [Condition: Code 'E13.6' from icd10] or
  exists [Condition: Code 'E13.61' from icd10] or
  exists [Condition: Code 'E13.60' from icd10] or
  exists [Condition: Code 'E13.9' from icd10] or
  exists [Condition: Code 'E13.91' from icd10] or
  exists [Condition: Code 'E13.90' from icd10]

define "3-Labor-1":
  exists [Observation: Code '718-7' from loinc]

define "3-Labor-2":
  exists [Observation: Code '17856-6' from loinc]

define "3-Labor-3":
  exists [Observation: Code '4548-4' from loinc]

define "3-Labor-4":
  exists [Observation: Code '4549-2' from loinc]

define "3-Labor":
  "3-Labor-1" or
  "3-Labor-2" or
  "3-Labor-3" or
  "3-Labor-4"

define "4-Prozedur-1":
  exists [Procedure: Code '3-20' from oops] or
  exists [Procedure: Code '3-20x' from oops] or
  exists [Procedure: Code '3-208' from oops] or
  exists [Procedure: Code '3-207' from oops] or
  exists [Procedure: Code '3-206' from oops] or
  exists [Procedure: Code '3-201' from oops] or
  exists [Procedure: Code '3-204' from oops] or
  exists [Procedure: Code '3-205' from oops] or
  exists [Procedure: Code '3-200' from oops] or
  exists [Procedure: Code '3-202' from oops] or
  exists [Procedure: Code '3-203' from oops]

define "4-Prozedur-2":
  exists [Procedure: Code '8-19' from oops] or
  exists [Procedure: Code '8-192' from oops] or
  exists [Procedure: Code '8-192.1' from oops] or
  exists [Procedure: Code '8-192.1b' from oops] or
  exists [Procedure: Code '8-192.1a' from oops] or
  exists [Procedure: Code '8-192.1g' from oops] or
  exists [Procedure: Code '8-192.1d' from oops] or
  exists [Procedure: Code '8-192.15' from oops] or
  exists [Procedure: Code '8-192.19' from oops] or
  exists [Procedure: Code '8-192.1c' from oops] or
  exists [Procedure: Code '8-192.10' from oops] or
  exists [Procedure: Code '8-192.17' from oops] or
  exists [Procedure: Code '8-192.1e' from oops] or
  exists [Procedure: Code '8-192.16' from oops] or
  exists [Procedure: Code '8-192.1x' from oops] or
  exists [Procedure: Code '8-192.14' from oops] or
  exists [Procedure: Code '8-192.18' from oops] or
  exists [Procedure: Code '8-192.1f' from oops] or
  exists [Procedure: Code '8-192.3' from oops] or
  exists [Procedure: Code '8-192.3b' from oops] or
  exists [Procedure: Code '8-192.3a' from oops] or
  exists [Procedure: Code '8-192.3g' from oops] or
  exists [Procedure: Code '8-192.3d' from oops] or
  exists [Procedure: Code '8-192.35' from oops] or
  exists [Procedure: Code '8-192.39' from oops] or
  exists [Procedure: Code '8-192.3c' from oops] or
  exists [Procedure: Code '8-192.30' from oops] or
  exists [Procedure: Code '8-192.37' from oops] or
  exists [Procedure: Code '8-192.3e' from oops] or
  exists [Procedure: Code '8-192.36' from oops] or
  exists [Procedure: Code '8-192.3x' from oops] or
  exists [Procedure: Code '8-192.34' from oops] or
  exists [Procedure: Code '8-192.38' from oops] or
  exists [Procedure: Code '8-192.3f' from oops] or
  exists [Procedure: Code '8-192.2' from oops] or
  exists [Procedure: Code '8-192.2b' from oops] or
  exists [Procedure: Code '8-192.2a' from oops] or
  exists [Procedure: Code '8-192.2g' from oops] or
  exists [Procedure: Code '8-192.2d' from oops] or
  exists [Procedure: Code '8-192.25' from oops] or
  exists [Procedure: Code '8-192.29' from oops] or
  exists [Procedure: Code '8-192.2c' from oops] or
  exists [Procedure: Code '8-192.20' from oops] or
  exists [Procedure: Code '8-192.27' from oops] or
  exists [Procedure: Code '8-192.2e' from oops] or
  exists [Procedure: Code '8-192.26' from oops] or
  exists [Procedure: Code '8-192.2x' from oops] or
  exists [Procedure: Code '8-192.24' from oops] or
  exists [Procedure: Code '8-192.28' from oops] or
  exists [Procedure: Code '8-192.2f' from oops] or
  exists [Procedure: Code '8-192.0' from oops] or
  exists [Procedure: Code '8-192.0b' from oops] or
  exists [Procedure: Code '8-192.0a' from oops] or
  exists [Procedure: Code '8-192.0g' from oops] or
  exists [Procedure: Code '8-192.0d' from oops] or
  exists [Procedure: Code '8-192.05' from oops] or
  exists [Procedure: Code '8-192.09' from oops] or
  exists [Procedure: Code '8-192.0c' from oops] or
  exists [Procedure: Code '8-192.00' from oops] or
  exists [Procedure: Code '8-192.07' from oops] or
  exists [Procedure: Code '8-192.0e' from oops] or
  exists [Procedure: Code '8-192.06' from oops] or
  exists [Procedure: Code '8-192.0x' from oops] or
  exists [Procedure: Code '8-192.04' from oops] or
  exists [Procedure: Code '8-192.08' from oops] or
  exists [Procedure: Code '8-192.0f' from oops] or
  exists [Procedure: Code '8-192.y' from oops] or
  exists [Procedure: Code '8-192.x' from oops] or
  exists [Procedure: Code '8-192.xb' from oops] or
  exists [Procedure: Code '8-192.xa' from oops] or
  exists [Procedure: Code '8-192.xg' from oops] or
  exists [Procedure: Code '8-192.xd' from oops] or
  exists [Procedure: Code '8-192.x5' from oops] or
  exists [Procedure: Code '8-192.x9' from oops] or
  exists [Procedure: Code '8-192.xc' from oops] or
  exists [Procedure: Code '8-192.x0' from oops] or
  exists [Procedure: Code '8-192.x7' from oops] or
  exists [Procedure: Code '8-192.xe' from oops] or
  exists [Procedure: Code '8-192.x6' from oops] or
  exists [Procedure: Code '8-192.xx' from oops] or
  exists [Procedure: Code '8-192.x4' from oops] or
  exists [Procedure: Code '8-192.x8' from oops] or
  exists [Procedure: Code '8-192.xf' from oops] or
  exists [Procedure: Code '8-190' from oops] or
  exists [Procedure: Code '8-190.2' from oops] or
  exists [Procedure: Code '8-190.22' from oops] or
  exists [Procedure: Code '8-190.21' from oops] or
  exists [Procedure: Code '8-190.20' from oops] or
  exists [Procedure: Code '8-190.23' from oops] or
  exists [Procedure: Code '8-190.4' from oops] or
  exists [Procedure: Code '8-190.42' from oops] or
  exists [Procedure: Code '8-190.41' from oops] or
  exists [Procedure: Code '8-190.40' from oops] or
  exists [Procedure: Code '8-190.43' from oops] or
  exists [Procedure: Code '8-190.3' from oops] or
  exists [Procedure: Code '8-190.32' from oops] or
  exists [Procedure: Code '8-190.31' from oops] or
  exists [Procedure: Code '8-190.30' from oops] or
  exists [Procedure: Code '8-190.33' from oops] or
  exists [Procedure: Code '8-191' from oops] or
  exists [Procedure: Code '8-191.1' from oops] or
  exists [Procedure: Code '8-191.11' from oops] or
  exists [Procedure: Code '8-191.10' from oops] or
  exists [Procedure: Code '8-191.2' from oops] or
  exists [Procedure: Code '8-191.21' from oops] or
  exists [Procedure: Code '8-191.20' from oops] or
  exists [Procedure: Code '8-191.0' from oops] or
  exists [Procedure: Code '8-191.01' from oops] or
  exists [Procedure: Code '8-191.00' from oops] or
  exists [Procedure: Code '8-191.5' from oops] or
  exists [Procedure: Code '8-191.y' from oops] or
  exists [Procedure: Code '8-191.7' from oops] or
  exists [Procedure: Code '8-191.72' from oops] or
  exists [Procedure: Code '8-191.73' from oops] or
  exists [Procedure: Code '8-191.74' from oops] or
  exists [Procedure: Code '8-191.75' from oops] or
  exists [Procedure: Code '8-191.76' from oops] or
  exists [Procedure: Code '8-191.77' from oops] or
  exists [Procedure: Code '8-191.78' from oops] or
  exists [Procedure: Code '8-191.79' from oops] or
  exists [Procedure: Code '8-191.71' from oops] or
  exists [Procedure: Code '8-191.70' from oops] or
  exists [Procedure: Code '8-191.6' from oops] or
  exists [Procedure: Code '8-191.x' from oops] or
  exists [Procedure: Code '8-191.4' from oops] or
  exists [Procedure: Code '8-191.41' from oops] or
  exists [Procedure: Code '8-191.40' from oops] or
  exists [Procedure: Code '8-191.3' from oops] or
  exists [Procedure: Code '8-191.31' from oops] or
  exists [Procedure: Code '8-191.30' from oops]

define "4-Prozedur":
  "4-Prozedur-1" or
  "4-Prozedur-2"

define "5-Konsent":
  exists (from [Consent] C
    where C.provision.provision.code.coding contains Code '2.16.840.1.113883.3.1937.777.24.5.3.8' from consent_policy)

define "6-Medikation":
  exists (from [MedicationAdministration] M
    where M.medication.reference in AntidiabetikaA10Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Andere AntidiabetikaA10XRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in AldosereduktasehemmerA10XARef) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in TolrestatA10XA01Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Homöopathische und anthroposophische AntidiabetikaA10XHRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in KombinationenA10XH20Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Pflanzliche AntidiabetikaA10XPRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in CopalchirindenextraktA10XP02Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Guar-MehlA10XP01Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in KombinationenA10XP30Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Antidiabetika, Exkl. InsulineA10BRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Alpha-GlukosidasehemmerA10BFRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in AcarboseA10BF01Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in MiglitolA10BF02Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in VogliboseA10BF03Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Andere Antidiabetika, exkl. InsulineA10BXRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in BenfluorexA10BX06Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Guar-Mehl*A10BX01Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in ImegliminA10BX15Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in MitiglinidA10BX08Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in NateglinidA10BX03Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in PramlintidA10BX05Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in RepaglinidA10BX02Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in BiguanideA10BARef) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in BuforminA10BA03Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in MetforminA10BA02Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in PhenforminA10BA01Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Dipeptidyl-Peptidase-4-(DPP-4)-InhibitorenA10BHRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in AlogliptinA10BH04Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in EvogliptinA10BH07Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in GemigliptinA10BH06Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Gemigliptin und RosuvastatinA10BH52Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in LinagliptinA10BH05Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in SaxagliptinA10BH03Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in SitagliptinA10BH01Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Sitagliptin und SimvastatinA10BH51Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in TeneligliptinA10BH08Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in VildagliptinA10BH02Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Glucagon-like-Peptid-1-(GLP-1)-RezeptoragonistenA10BJRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in AlbiglutidA10BJ04Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in BeinaglutidA10BJ07Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in DulaglutidA10BJ05Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in ExenatidA10BJ01Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in LiraglutidA10BJ02Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in LixisenatidA10BJ03Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in SemaglutidA10BJ06Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Kombinationen oraler AntidiabetikaA10BDRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Glimepirid und PioglitazonA10BD06Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Glimepirid und RosiglitazonA10BD04Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Linagliptin und EmpagliflozinA10BD19Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und AcarboseA10BD17Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und AlogliptinA10BD13Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und CanagliflozinA10BD16Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und DapagliflozinA10BD15Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und EmpagliflozinA10BD20Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und ErtugliflozinA10BD23Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und EvogliptinA10BD22Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und GemigliptinA10BD18Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und GlibenclamidA10BD31Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und LinagliptinA10BD11Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und LobeglitazonA10BD26Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und PioglitazonA10BD05Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und RepaglinidA10BD14Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und RosiglitazonA10BD03Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und SaxagliptinA10BD10Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und SitagliptinA10BD07Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und SulfonylharnstoffeA10BD02Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin und VildagliptinA10BD08Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin, Linagliptin und EmpagliflozinA10BD27Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Metformin, Saxagliptin und DapagliflozinA10BD25Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Phenformin und SulfonylharnstoffeA10BD01Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Pioglitazon und AlogliptinA10BD09Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Pioglitazon und SitagliptinA10BD12Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Saxagliptin und DapagliflozinA10BD21Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Sitagliptin und ErtugliflozinA10BD24Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Natrium-Glucose-Cotransporter-2-(SGLT2)-InhibitorenA10BKRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in CanagliflozinA10BK02Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in DapagliflozinA10BK01Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in EmpagliflozinA10BK03Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in ErtugliflozinA10BK04Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in IpragliflozinA10BK05Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in LuseogliflozinA10BK07Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in SotagliflozinA10BK06Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Sulfonamide (heterozyklisch)A10BCRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in GlymidinA10BC01Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in SulfonylharnstoffeA10BBRef) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in AcetohexamidA10BB31Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in CarbutamidA10BB06Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in ChlorpropamidA10BB02Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in GlibenclamidA10BB01Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in GlibornuridA10BB04Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in GliclazidA10BB09Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in GlimepiridA10BB12Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in GlipizidA10BB07Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in GliquidonA10BB08Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in GlisoxepidA10BB11Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in MetahexamidA10BB10Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in TolazamidA10BB05Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in TolbutamidA10BB03Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Thiazolidindione (Glitazone)A10BGRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in LobeglitazonA10BG04Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in PioglitazonA10BG03Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in RosiglitazonA10BG02Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in TroglitazonA10BG01Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insuline Und AnalogaA10ARef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insuline und Analoga zur InhalationA10AFRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin (human)A10AF01Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insuline und Analoga zur Injektion, intermediär oder lang wirkend kombiniert mit schnell wirkendA10ADRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin (human)A10AD01Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin (Rind)A10AD02Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin (Schwein)A10AD03Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin aspartA10AD05Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin degludec und Insulin aspartA10AD06Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin lisproA10AD04Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in KombinationenA10AD30Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insuline und Analoga zur Injektion, intermediär wirkendA10ACRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin (human)A10AC01Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin (Rind)A10AC02Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin (Schwein)A10AC03Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin lisproA10AC04Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in KombinationenA10AC30Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insuline und Analoga zur Injektion, lang wirkendA10AERef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin (human)A10AE01Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin (Rind)A10AE02Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin (Schwein)A10AE03Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin degludecA10AE06Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin degludec und LiraglutidA10AE56Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin detemirA10AE05Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin glarginA10AE04Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin glargin und LixisenatidA10AE54Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in KombinationenA10AE30Ref) or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insuline und Analoga zur Injektion, schnell wirkendA10ABRef") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin (human)A10AB01Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin (Rind)A10AB02Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin (Schwein)A10AB03Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin aspartA10AB05Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin glulisinA10AB06Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in "Insulin lisproA10AB04Ref") or
  exists (from [MedicationAdministration] M
    where M.medication.reference in KombinationenA10AB30Ref)

define "7-Specimen-1":
  exists [Specimen: Code '119297000' from snomed] or
  exists [Specimen: Code '122552005' from snomed] or
  exists [Specimen: Code '703430008' from snomed] or
  exists [Specimen: Code '303248007' from snomed] or
  exists [Specimen: Code '737535000' from snomed] or
  exists [Specimen: Code '122560006' from snomed] or
  exists [Specimen: Code '122581006' from snomed] or
  exists [Specimen: Code '122589008' from snomed] or
  exists [Specimen: Code '122558009' from snomed] or
  exists [Specimen: Code '2541000181108' from snomed] or
  exists [Specimen: Code '122591000' from snomed] or
  exists [Specimen: Code '122559001' from snomed] or
  exists [Specimen: Code '122587005' from snomed] or
  exists [Specimen: Code '122562003' from snomed] or
  exists [Specimen: Code '122561005' from snomed] or
  exists [Specimen: Code '122583009' from snomed] or
  exists [Specimen: Code '122588000' from snomed] or
  exists [Specimen: Code '122590004' from snomed] or
  exists [Specimen: Code '446131002' from snomed] or
  exists [Specimen: Code '878861003' from snomed] or
  exists [Specimen: Code '866033003' from snomed] or
  exists [Specimen: Code '866032008' from snomed] or
  exists [Specimen: Code '122553000' from snomed] or
  exists [Specimen: Code '122556008' from snomed] or
  exists [Specimen: Code '122557004' from snomed] or
  exists [Specimen: Code '703431007' from snomed] or
  exists [Specimen: Code '446272009' from snomed] or
  exists [Specimen: Code '441510007' from snomed] or
  exists [Specimen: Code '445295009' from snomed] or
  exists [Specimen: Code '57921000052103' from snomed] or
  exists [Specimen: Code '122554006' from snomed] or
  exists [Specimen: Code '258581004' from snomed] or
  exists [Specimen: Code '119294007' from snomed] or
  exists [Specimen: Code '440500007' from snomed] or
  exists [Specimen: Code '737357006' from snomed] or
  exists [Specimen: Code '119345009' from snomed] or
  exists [Specimen: Code '122551003' from snomed] or
  exists [Specimen: Code '788707000' from snomed] or
  exists [Specimen: Code '122592007' from snomed] or
  exists [Specimen: Code '119361006' from snomed] or
  exists [Specimen: Code '2431000181102' from snomed] or
  exists [Specimen: Code '2441000181109' from snomed] or
  exists [Specimen: Code '898205005' from snomed] or
  exists [Specimen: Code '2451000181107' from snomed] or
  exists [Specimen: Code '708048008' from snomed] or
  exists [Specimen: Code '708049000' from snomed] or
  exists [Specimen: Code '119362004' from snomed] or
  exists [Specimen: Code '737356002' from snomed] or
  exists [Specimen: Code '119363009' from snomed] or
  exists [Specimen: Code '703432000' from snomed] or
  exists [Specimen: Code '119364003' from snomed] or
  exists [Specimen: Code '258590006' from snomed] or
  exists [Specimen: Code '866034009' from snomed] or
  exists [Specimen: Code '2421000181104' from snomed] or
  exists [Specimen: Code '866035005' from snomed] or
  exists [Specimen: Code '442427000' from snomed] or
  exists [Specimen: Code '737089009' from snomed] or
  exists [Specimen: Code '258580003' from snomed] or
  exists [Specimen: Code '122555007' from snomed] or
  exists [Specimen: Code '119298005' from snomed]

define "7-Specimen-2":
  exists [Specimen: Code '119361006' from snomed] or
  exists [Specimen: Code '2431000181102' from snomed] or
  exists [Specimen: Code '2441000181109' from snomed] or
  exists [Specimen: Code '898205005' from snomed] or
  exists [Specimen: Code '2451000181107' from snomed] or
  exists [Specimen: Code '708048008' from snomed] or
  exists [Specimen: Code '708049000' from snomed] or
  exists [Specimen: Code '119362004' from snomed] or
  exists [Specimen: Code '737356002' from snomed] or
  exists [Specimen: Code '119363009' from snomed] or
  exists [Specimen: Code '703432000' from snomed]

define "7-Specimen-3":
  exists [Specimen: Code '119376003' from snomed] or
  exists [Specimen: Code '33631000087102' from snomed] or
  exists [Specimen: Code '309126004' from snomed] or
  exists [Specimen: Code '309127008' from snomed] or
  exists [Specimen: Code '258417006' from snomed] or
  exists [Specimen: Code '16211651000119103' from snomed] or
  exists [Specimen: Code '446304007' from snomed] or
  exists [Specimen: Code '258418001' from snomed] or
  exists [Specimen: Code '430970004' from snomed] or
  exists [Specimen: Code '258419009' from snomed] or
  exists [Specimen: Code '122703009' from snomed] or
  exists [Specimen: Code '309067007' from snomed] or
  exists [Specimen: Code '447155001' from snomed] or
  exists [Specimen: Code '399751008' from snomed] or
  exists [Specimen: Code '399396003' from snomed] or
  exists [Specimen: Code '309274005' from snomed] or
  exists [Specimen: Code '791000009104' from snomed] or
  exists [Specimen: Code '441652008' from snomed] or
  exists [Specimen: Code '16222251000119102' from snomed] or
  exists [Specimen: Code '441479001' from snomed] or
  exists [Specimen: Code '16214131000119104' from snomed] or
  exists [Specimen: Code '16222091000119100' from snomed] or
  exists [Specimen: Code '309078004' from snomed] or
  exists [Specimen: Code '309482007' from snomed] or
  exists [Specimen: Code '373192005' from snomed] or
  exists [Specimen: Code '384744003' from snomed] or
  exists [Specimen: Code '373193000' from snomed] or
  exists [Specimen: Code '309476009' from snomed] or
  exists [Specimen: Code '397436009' from snomed] or
  exists [Specimen: Code '399649002' from snomed] or
  exists [Specimen: Code '396359006' from snomed] or
  exists [Specimen: Code '397136001' from snomed] or
  exists [Specimen: Code '399661005' from snomed] or
  exists [Specimen: Code '446842008' from snomed] or
  exists [Specimen: Code '430861001' from snomed] or
  exists [Specimen: Code '1201985008' from snomed] or
  exists [Specimen: Code '430856003' from snomed] or
  exists [Specimen: Code '309129006' from snomed] or
  exists [Specimen: Code '3040001000004107' from snomed] or
  exists [Specimen: Code '309150002' from snomed] or
  exists [Specimen: Code '309153000' from snomed] or
  exists [Specimen: Code '258484005' from snomed] or
  exists [Specimen: Code '258428005' from snomed] or
  exists [Specimen: Code '446837000' from snomed] or
  exists [Specimen: Code '122736005' from snomed] or
  exists [Specimen: Code '725957005' from snomed] or
  exists [Specimen: Code '258426009' from snomed] or
  exists [Specimen: Code '399657004' from snomed] or
  exists [Specimen: Code '399658009' from snomed] or
  exists [Specimen: Code '399447007' from snomed] or
  exists [Specimen: Code '399502008' from snomed] or
  exists [Specimen: Code '258436001' from snomed] or
  exists [Specimen: Code '309072003' from snomed] or
  exists [Specimen: Code '258414004' from snomed] or
  exists [Specimen: Code '309110000' from snomed] or
  exists [Specimen: Code '309112008' from snomed] or
  exists [Specimen: Code '1177151008' from snomed] or
  exists [Specimen: Code '438336007' from snomed] or
  exists [Specimen: Code '309495002' from snomed] or
  exists [Specimen: Code '309496001' from snomed] or
  exists [Specimen: Code '440502004' from snomed] or
  exists [Specimen: Code '309119004' from snomed] or
  exists [Specimen: Code '309485009' from snomed] or
  exists [Specimen: Code '309108002' from snomed] or
  exists [Specimen: Code '16210411000119108' from snomed] or
  exists [Specimen: Code '396355000' from snomed] or
  exists [Specimen: Code '396353007' from snomed] or
  exists [Specimen: Code '396354001' from snomed] or
  exists [Specimen: Code '608856009' from snomed] or
  exists [Specimen: Code '309121009' from snomed] or
  exists [Specimen: Code '725372003' from snomed] or
  exists [Specimen: Code '128160006' from snomed] or
  exists [Specimen: Code '119325001' from snomed] or
  exists [Specimen: Code '258549008' from snomed] or
  exists [Specimen: Code '396356004' from snomed] or
  exists [Specimen: Code '396357008' from snomed] or
  exists [Specimen: Code '396358003' from snomed] or
  exists [Specimen: Code '446951004' from snomed] or
  exists [Specimen: Code '447407009' from snomed] or
  exists [Specimen: Code '406101006' from snomed] or
  exists [Specimen: Code '127457009' from snomed] or
  exists [Specimen: Code '309059004' from snomed] or
  exists [Specimen: Code '397199005' from snomed] or
  exists [Specimen: Code '309546004' from snomed] or
  exists [Specimen: Code '309547008' from snomed] or
  exists [Specimen: Code '122596005' from snomed] or
  exists [Specimen: Code '122597001' from snomed] or
  exists [Specimen: Code '122598006' from snomed] or
  exists [Specimen: Code '16211771000119103' from snomed] or
  exists [Specimen: Code '122599003' from snomed] or
  exists [Specimen: Code '122600000' from snomed] or
  exists [Specimen: Code '16211731000119101' from snomed] or
  exists [Specimen: Code '122595009' from snomed] or
  exists [Specimen: Code '399542003' from snomed] or
  exists [Specimen: Code '399732002' from snomed] or
  exists [Specimen: Code '399614009' from snomed] or
  exists [Specimen: Code '128157004' from snomed] or
  exists [Specimen: Code '363328006' from snomed] or
  exists [Specimen: Code '309491006' from snomed] or
  exists [Specimen: Code '399541005' from snomed] or
  exists [Specimen: Code '127468009' from snomed] or
  exists [Specimen: Code '122658000' from snomed] or
  exists [Specimen: Code '122659008' from snomed] or
  exists [Specimen: Code '122660003' from snomed] or
  exists [Specimen: Code '1172660005' from snomed] or
  exists [Specimen: Code '397482001' from snomed] or
  exists [Specimen: Code '397483006' from snomed] or
  exists [Specimen: Code '369615004' from snomed] or
  exists [Specimen: Code '122656001' from snomed] or
  exists [Specimen: Code '309205005' from snomed] or
  exists [Specimen: Code '369617007' from snomed] or
  exists [Specimen: Code '309186001' from snomed] or
  exists [Specimen: Code '309187005' from snomed] or
  exists [Specimen: Code '309190004' from snomed] or
  exists [Specimen: Code '309486005' from snomed] or
  exists [Specimen: Code '309484008' from snomed] or
  exists [Specimen: Code '399484009' from snomed] or
  exists [Specimen: Code '399693002' from snomed] or
  exists [Specimen: Code '734379005' from snomed] or
  exists [Specimen: Code '399645008' from snomed] or
  exists [Specimen: Code '127466008' from snomed] or
  exists [Specimen: Code '128156008' from snomed] or
  exists [Specimen: Code '309266009' from snomed] or
  exists [Specimen: Code '399731009' from snomed] or
  exists [Specimen: Code '309267000' from snomed] or
  exists [Specimen: Code '399752001' from snomed] or
  exists [Specimen: Code '385338007' from snomed] or
  exists [Specimen: Code '385340002' from snomed] or
  exists [Specimen: Code '385339004' from snomed] or
  exists [Specimen: Code '127464006' from snomed] or
  exists [Specimen: Code '122630008' from snomed] or
  exists [Specimen: Code '122631007' from snomed] or
  exists [Specimen: Code '122643008' from snomed] or
  exists [Specimen: Code '122645001' from snomed] or
  exists [Specimen: Code '309200000' from snomed] or
  exists [Specimen: Code '309264007' from snomed] or
  exists [Specimen: Code '309489003' from snomed] or
  exists [Specimen: Code '122653009' from snomed] or
  exists [Specimen: Code '122655002' from snomed] or
  exists [Specimen: Code '122654003' from snomed] or
  exists [Specimen: Code '309263001' from snomed] or
  exists [Specimen: Code '258430007' from snomed] or
  exists [Specimen: Code '421615004' from snomed] or
  exists [Specimen: Code '423696009' from snomed] or
  exists [Specimen: Code '422991009' from snomed] or
  exists [Specimen: Code '122646000' from snomed] or
  exists [Specimen: Code '128159001' from snomed] or
  exists [Specimen: Code '309223002' from snomed] or
  exists [Specimen: Code '309488006' from snomed] or
  exists [Specimen: Code '122650007' from snomed] or
  exists [Specimen: Code '122648004' from snomed] or
  exists [Specimen: Code '122651006' from snomed] or
  exists [Specimen: Code '122649007' from snomed] or
  exists [Specimen: Code '309487001' from snomed] or
  exists [Specimen: Code '122647009' from snomed] or
  exists [Specimen: Code '309224008' from snomed] or
  exists [Specimen: Code '309226005' from snomed] or
  exists [Specimen: Code '309227001' from snomed] or
  exists [Specimen: Code '122652004' from snomed] or
  exists [Specimen: Code '122638001' from snomed] or
  exists [Specimen: Code '309220004' from snomed] or
  exists [Specimen: Code '309218002' from snomed] or
  exists [Specimen: Code '122641005' from snomed] or
  exists [Specimen: Code '309221000' from snomed] or
  exists [Specimen: Code '122640006' from snomed] or
  exists [Specimen: Code '397053005' from snomed] or
  exists [Specimen: Code '397055003' from snomed] or
  exists [Specimen: Code '397056002' from snomed] or
  exists [Specimen: Code '122639009' from snomed] or
  exists [Specimen: Code '122642003' from snomed] or
  exists [Specimen: Code '128171007' from snomed] or
  exists [Specimen: Code '399629006' from snomed] or
  exists [Specimen: Code '122633005' from snomed] or
  exists [Specimen: Code '122635003' from snomed] or
  exists [Specimen: Code '122637006' from snomed] or
  exists [Specimen: Code '122636002' from snomed] or
  exists [Specimen: Code '122634004' from snomed] or
  exists [Specimen: Code '438351003' from snomed] or
  exists [Specimen: Code '128168004' from snomed] or
  exists [Specimen: Code '396481000' from snomed] or
  exists [Specimen: Code '439034006' from snomed] or
  exists [Specimen: Code '16212131000119106' from snomed] or
  exists [Specimen: Code '396479002' from snomed] or
  exists [Specimen: Code '396478005' from snomed] or
  exists [Specimen: Code '16212091000119109' from snomed] or
  exists [Specimen: Code '396476009' from snomed] or
  exists [Specimen: Code '396477000' from snomed] or
  exists [Specimen: Code '396480004' from snomed] or
  exists [Specimen: Code '127470000' from snomed] or
  exists [Specimen: Code '309490007' from snomed] or
  exists [Specimen: Code '122661004' from snomed] or
  exists [Specimen: Code '57481000052108' from snomed] or
  exists [Specimen: Code '122665008' from snomed] or
  exists [Specimen: Code '396806000' from snomed] or
  exists [Specimen: Code '396807009' from snomed] or
  exists [Specimen: Code '122666009' from snomed] or
  exists [Specimen: Code '396804002' from snomed] or
  exists [Specimen: Code '396805001' from snomed] or
  exists [Specimen: Code '122662006' from snomed] or
  exists [Specimen: Code '122663001' from snomed] or
  exists [Specimen: Code '122664007' from snomed] or
  exists [Specimen: Code '128172000' from snomed] or
  exists [Specimen: Code '440469007' from snomed] or
  exists [Specimen: Code '128164002' from snomed] or
  exists [Specimen: Code '258425008' from snomed] or
  exists [Specimen: Code '399443006' from snomed] or
  exists [Specimen: Code '399603006' from snomed] or
  exists [Specimen: Code '399499009' from snomed] or
  exists [Specimen: Code '396928004' from snomed] or
  exists [Specimen: Code '399512001' from snomed] or
  exists [Specimen: Code '399559008' from snomed] or
  exists [Specimen: Code '399735000' from snomed] or
  exists [Specimen: Code '399640003' from snomed] or
  exists [Specimen: Code '399467003' from snomed] or
  exists [Specimen: Code '128161005' from snomed] or
  exists [Specimen: Code '16212811000119105' from snomed] or
  exists [Specimen: Code '447403008' from snomed] or
  exists [Specimen: Code '399451009' from snomed] or
  exists [Specimen: Code '33921000087105' from snomed] or
  exists [Specimen: Code '399619004' from snomed] or
  exists [Specimen: Code '33911000087102' from snomed] or
  exists [Specimen: Code '128165001' from snomed] or
  exists [Specimen: Code '309278008' from snomed] or
  exists [Specimen: Code '127483004' from snomed] or
  exists [Specimen: Code '122720008' from snomed] or
  exists [Specimen: Code '122719002' from snomed] or
  exists [Specimen: Code '399388008' from snomed] or
  exists [Specimen: Code '765469005' from snomed] or
  exists [Specimen: Code '309287004' from snomed] or
  exists [Specimen: Code '397326000' from snomed] or
  exists [Specimen: Code '765470006' from snomed] or
  exists [Specimen: Code '122721007' from snomed] or
  exists [Specimen: Code '397334006' from snomed] or
  exists [Specimen: Code '122723005' from snomed] or
  exists [Specimen: Code '397333000' from snomed] or
  exists [Specimen: Code '122722000' from snomed] or
  exists [Specimen: Code '127482009' from snomed] or
  exists [Specimen: Code '122710003' from snomed] or
  exists [Specimen: Code '122716009' from snomed] or
  exists [Specimen: Code '122718005' from snomed] or
  exists [Specimen: Code '122712006' from snomed] or
  exists [Specimen: Code '397246008' from snomed] or
  exists [Specimen: Code '397245007' from snomed] or
  exists [Specimen: Code '122711004' from snomed] or
  exists [Specimen: Code '122717000' from snomed] or
  exists [Specimen: Code '122713001' from snomed] or
  exists [Specimen: Code '122714007' from snomed] or
  exists [Specimen: Code '122715008' from snomed] or
  exists [Specimen: Code '127480001' from snomed] or
  exists [Specimen: Code '309501000' from snomed] or
  exists [Specimen: Code '122705002' from snomed] or
  exists [Specimen: Code '309289001' from snomed] or
  exists [Specimen: Code '122706001' from snomed] or
  exists [Specimen: Code '122700007' from snomed] or
  exists [Specimen: Code '396273004' from snomed] or
  exists [Specimen: Code '309285007' from snomed] or
  exists [Specimen: Code '122701006' from snomed] or
  exists [Specimen: Code '122696004' from snomed] or
  exists [Specimen: Code '122697008' from snomed] or
  exists [Specimen: Code '122707005' from snomed] or
  exists [Specimen: Code '122702004' from snomed] or
  exists [Specimen: Code '128163008' from snomed] or
  exists [Specimen: Code '309288009' from snomed] or
  exists [Specimen: Code '127481002' from snomed] or
  exists [Specimen: Code '309286008' from snomed] or
  exists [Specimen: Code '16210931000119105' from snomed] or
  exists [Specimen: Code '128175003' from snomed] or
  exists [Specimen: Code '122693007' from snomed] or
  exists [Specimen: Code '397111007' from snomed] or
  exists [Specimen: Code '122694001' from snomed] or
  exists [Specimen: Code '399486006' from snomed] or
  exists [Specimen: Code '397130007' from snomed] or
  exists [Specimen: Code '397131006' from snomed] or
  exists [Specimen: Code '397132004' from snomed] or
  exists [Specimen: Code '397133009' from snomed] or
  exists [Specimen: Code '397134003' from snomed] or
  exists [Specimen: Code '258422006' from snomed] or
  exists [Specimen: Code '127475005' from snomed] or
  exists [Specimen: Code '309138008' from snomed] or
  exists [Specimen: Code '128169007' from snomed] or
  exists [Specimen: Code '128170008' from snomed] or
  exists [Specimen: Code '309133004' from snomed] or
  exists [Specimen: Code '122724004' from snomed] or
  exists [Specimen: Code '122725003' from snomed] or
  exists [Specimen: Code '122726002' from snomed] or
  exists [Specimen: Code '16222611000119100' from snomed] or
  exists [Specimen: Code '122727006' from snomed] or
  exists [Specimen: Code '384820007' from snomed] or
  exists [Specimen: Code '128166000' from snomed] or
  exists [Specimen: Code '258424007' from snomed] or
  exists [Specimen: Code '433781000124108' from snomed] or
  exists [Specimen: Code '258407001' from snomed] or
  exists [Specimen: Code '444824001' from snomed] or
  exists [Specimen: Code '258420003' from snomed] or
  exists [Specimen: Code '309179009' from snomed] or
  exists [Specimen: Code '703475006' from snomed] or
  exists [Specimen: Code '1173996004' from snomed] or
  exists [Specimen: Code '258435002' from snomed] or
  exists [Specimen: Code '16210811000119106' from snomed] or
  exists [Specimen: Code '699874006' from snomed] or
  exists [Specimen: Code '397462000' from snomed] or
  exists [Specimen: Code '363329003' from snomed] or
  exists [Specimen: Code '309170008' from snomed] or
  exists [Specimen: Code '128158009' from snomed] or
  exists [Specimen: Code '399492000' from snomed] or
  exists [Specimen: Code '309175003' from snomed] or
  exists [Specimen: Code '122606006' from snomed] or
  exists [Specimen: Code '122605005' from snomed] or
  exists [Specimen: Code '122607002' from snomed] or
  exists [Specimen: Code '122604009' from snomed] or
  exists [Specimen: Code '440472000' from snomed] or
  exists [Specimen: Code '122608007' from snomed] or
  exists [Specimen: Code '128173005' from snomed] or
  exists [Specimen: Code '438352005' from snomed] or
  exists [Specimen: Code '127460002' from snomed] or
  exists [Specimen: Code '127461003' from snomed] or
  exists [Specimen: Code '309168004' from snomed] or
  exists [Specimen: Code '309183009' from snomed] or
  exists [Specimen: Code '16213851000119101' from snomed] or
  exists [Specimen: Code '128167009' from snomed] or
  exists [Specimen: Code '438803004' from snomed] or
  exists [Specimen: Code '303247002' from snomed] or
  exists [Specimen: Code '309143001' from snomed] or
  exists [Specimen: Code '396526009' from snomed] or
  exists [Specimen: Code '396527000' from snomed] or
  exists [Specimen: Code '127474009' from snomed] or
  exists [Specimen: Code '309270001' from snomed] or
  exists [Specimen: Code '309498000' from snomed] or
  exists [Specimen: Code '122682005' from snomed] or
  exists [Specimen: Code '122683000' from snomed] or
  exists [Specimen: Code '122684006' from snomed] or
  exists [Specimen: Code '122685007' from snomed] or
  exists [Specimen: Code '122676007' from snomed] or
  exists [Specimen: Code '122677003' from snomed] or
  exists [Specimen: Code '122678008' from snomed] or
  exists [Specimen: Code '122679000' from snomed] or
  exists [Specimen: Code '397232008' from snomed] or
  exists [Specimen: Code '397235005' from snomed] or
  exists [Specimen: Code '397234009' from snomed] or
  exists [Specimen: Code '309497005' from snomed] or
  exists [Specimen: Code '399741007' from snomed] or
  exists [Specimen: Code '122680002' from snomed] or
  exists [Specimen: Code '122681003' from snomed] or
  exists [Specimen: Code '122690005' from snomed] or
  exists [Specimen: Code '122674005' from snomed] or
  exists [Specimen: Code '122675006' from snomed] or
  exists [Specimen: Code '122689001' from snomed] or
  exists [Specimen: Code '399532000' from snomed] or
  exists [Specimen: Code '438804005' from snomed] or
  exists [Specimen: Code '733103005' from snomed] or
  exists [Specimen: Code '399672000' from snomed] or
  exists [Specimen: Code '399572009' from snomed] or
  exists [Specimen: Code '127478007' from snomed] or
  exists [Specimen: Code '399689008' from snomed] or
  exists [Specimen: Code '122735009' from snomed] or
  exists [Specimen: Code '122732007' from snomed] or
  exists [Specimen: Code '122734008' from snomed] or
  exists [Specimen: Code '122733002' from snomed] or
  exists [Specimen: Code '399622002' from snomed] or
  exists [Specimen: Code '127472008' from snomed] or
  exists [Specimen: Code '122668005' from snomed] or
  exists [Specimen: Code '16212171000119109' from snomed] or
  exists [Specimen: Code '399624001' from snomed] or
  exists [Specimen: Code '399407000' from snomed] or
  exists [Specimen: Code '399440009' from snomed] or
  exists [Specimen: Code '128174004' from snomed] or
  exists [Specimen: Code '309272009' from snomed] or
  exists [Specimen: Code '309275006' from snomed] or
  exists [Specimen: Code '122686008' from snomed] or
  exists [Specimen: Code '122687004' from snomed] or
  exists [Specimen: Code '396685001' from snomed] or
  exists [Specimen: Code '122688009' from snomed] or
  exists [Specimen: Code '309276007' from snomed] or
  exists [Specimen: Code '122669002' from snomed] or
  exists [Specimen: Code '439479000' from snomed] or
  exists [Specimen: Code '258585008' from snomed] or
  exists [Specimen: Code '309103006' from snomed] or
  exists [Specimen: Code '309116006' from snomed] or
  exists [Specimen: Code '737016007' from snomed] or
  exists [Specimen: Code '439895009' from snomed] or
  exists [Specimen: Code '788524009' from snomed] or
  exists [Specimen: Code '16222771000119104' from snomed] or
  exists [Specimen: Code '369613006' from snomed] or
  exists [Specimen: Code '122593002' from snomed] or
  exists [Specimen: Code '431196006' from snomed]

define "7-Specimen-4":
  exists [Specimen: Code '441652008' from snomed] or
  exists [Specimen: Code '16222251000119102' from snomed]

define "7-Specimen-5":
  exists [Specimen: Code '441479001' from snomed]

define "7-Specimen-6":
  exists [Specimen: Code '258580003' from snomed]

define "7-Specimen":
  "7-Specimen-1" or
  "7-Specimen-2" or
  "7-Specimen-3" or
  "7-Specimen-4" or
  "7-Specimen-5" or
  "7-Specimen-6"

define InInitialPopulation:
  "1-Patient" and
  "2-Condition" and
  "3-Labor" and
  "4-Prozedur" and
  "5-Konsent" and
  "6-Medikation" and
  "7-Specimen"
