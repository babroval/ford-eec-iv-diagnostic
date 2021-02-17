package babroval.eec_iv.dao;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import babroval.eec_iv.model.Parameter;
import babroval.eec_iv.util.CsvUtil;

public class ParameterDaoImpl implements Dao<Parameter> {

	@Override
	public List<Parameter> loadAll(InputStream csvFile) {

		String cvsSplitBy = ",";
		List<String> allLines = CsvUtil.loadAllLinesFromCsvFile(csvFile);

		List<Parameter> allEntities = new ArrayList<>();

		for (String line : allLines) {

			String[] csvLine = line.split(cvsSplitBy);
			Parameter entity = createEntity(csvLine);
			allEntities.add(entity);
		}
		return allEntities;
	}

	private static Parameter createEntity(String[] csvLine) {

		try {
			Integer parameter_id = Integer.valueOf(csvLine[0].trim());
			String parameterNumber = csvLine[1].trim();
			String parameterName = csvLine[2].trim();
			String parameterValue = "";

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
}
