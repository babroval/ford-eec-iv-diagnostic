package babroval.eec_iv.dao;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import babroval.eec_iv.model.Fault;
import babroval.eec_iv.util.CsvUtil;

public class FaultDaoImpl implements Dao<Fault> {

	@Override
	public List<Fault> loadAll(InputStream csvFile) {

		String cvsSplitBy = ",";
		List<String> allLines = CsvUtil.loadAllLinesFromCsvFile(csvFile);

		List<Fault> allEntities = new ArrayList<>();

		for (String line : allLines) {

			String[] csvLine = line.split(cvsSplitBy);
			Fault entity = createEntity(csvLine);
			allEntities.add(entity);
		}
		return allEntities;
	}

	private static Fault createEntity(String[] csvLine) {

		try {
			Integer fault_id = Integer.valueOf(csvLine[0].trim());
			String faultNumber = csvLine[1].trim();
			String info = csvLine[2].trim();

			Fault entity = new Fault();

			entity.setFault_id(fault_id);
			entity.setNumber(faultNumber);
			entity.setInfo(info);

			return entity;

		} catch (Exception e) {
			throw new RuntimeException("incorrect data in CSV file", e);
		}
	}
}
