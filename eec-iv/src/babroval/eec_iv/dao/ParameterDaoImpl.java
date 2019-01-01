package babroval.eec_iv.dao;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

import babroval.eec_iv.model.Parameter;

public class ParameterDaoImpl implements Dao<Parameter> {

	@Override
	public List<Parameter> loadAllParameters(String csvFilePath, StringBuffer data) {

		File csvFile = new File(csvFilePath);
		String line = "";
		String cvsSplitBy = ",";

		try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {

			if (csvFile.length() == 0) {
				throw new RuntimeException("CSV file is empty");
			}

			List<Parameter> allParameters = new ArrayList<Parameter>();
			int id = 0;

			while ((line = br.readLine()) != null) {

				line = ++id + "," + line;
				String[] csvLine = line.split(cvsSplitBy);
				Parameter parameter = createParameterEntity(csvLine, data);
				allParameters.add(parameter);
			}

			return allParameters;

		} catch (Exception e) {
			throw new RuntimeException(e);
		}

	}

	private static Parameter createParameterEntity(String[] csvLine, StringBuffer data) {

		try {

			Integer parameter_id = Integer.valueOf(csvLine[0].trim());
			String parameterNumber = csvLine[1].trim();
			String parameterName = csvLine[2].trim();
			String parameterValue = getParameterValue(parameterNumber, data);

			Parameter entity = new Parameter();

			entity.setParameter_id(parameter_id);
			entity.setNumber(parameterNumber);
			entity.setName(parameterName);
			entity.setValue(parameterValue);

			return entity;

		} catch (Exception e) {
			throw new RuntimeException("incorrect data in CSV file", e);
		}
	}

	private static String getParameterValue(String parameterNumber, StringBuffer data) {

		String value = "";
		switch (parameterNumber) {
		case "1":
			value = data.substring(0, 4);
			break;
		case "2":
			value = data.substring(4, 8);
			break;
		case "3":
			value = data.substring(8, 12);
			break;
		case "4":
			value = data.substring(12, 16);
			break;
		case "5":
			value = data.substring(16, 20);
			break;
		case "6":
			value = data.substring(20, 24);
			break;
		case "7":
			value = data.substring(24, 28);
			break;
		case "8":
			value = data.substring(28, 32);
			break;
		case "9":
			value = data.substring(32, 36);
			break;
		case "10":
			value = data.substring(36, 40);
			break;
		case "11":
			value = data.substring(40, 44);
			break;
		case "12":
			value = data.substring(44, 48);
			break;
		case "13":
			value = data.substring(48, 52);
			break;
		case "14":
			value = data.substring(52, 56);
			break;
		case "15":
			value = data.substring(56, 60);
			break;
		case "16":
			value = data.substring(60, 64);
			break;
		case "17":
			value = data.substring(60, 64);
			break;
		default:
			throw new RuntimeException("incorrect data");
		}
		return value;
	}

	@Override
	public List<Parameter> loadAllFaults(String csvFilePath) {
		throw new UnsupportedOperationException("Method has not implemented yet");
	}

}
