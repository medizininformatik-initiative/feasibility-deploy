library "6-Medication"
using FHIR version '4.0.0'
include FHIRHelpers version '4.0.0'

codesystem atc: 'http://fhir.de/CodeSystem/bfarm/atc'

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

define Criterion:
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

define InInitialPopulation:
  Criterion
