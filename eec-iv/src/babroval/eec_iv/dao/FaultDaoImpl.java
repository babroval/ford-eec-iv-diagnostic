package babroval.eec_iv.dao;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

import babroval.eec_iv.model.Fault;

public class FaultDaoImpl implements Dao<Fault> {

	@Override
	public List<Fault> loadAllFaults(String csvFilePath) {

		File csvFile = new File(csvFilePath);
		String line = "";
		String cvsSplitBy = ",";

		try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {

			if (csvFile.length() == 0) {
				throw new RuntimeException();
			}

			List<Fault> allFaults = new ArrayList<Fault>();
			int id = 0;

			while ((line = br.readLine()) != null) {

				line = ++id + "," + line;

				String[] csvLine = line.split(cvsSplitBy);
				Fault fault = createFaultEntity(csvLine);

				allFaults.add(fault);
			}

			return allFaults;

		} catch (Exception e) {
			throw new RuntimeException(e);
		}

	}

	private static Fault createFaultEntity(String[] csvLine) {

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

	@Override
	public List<Fault> loadAllParameters(String csvFilePath, StringBuffer data) {
		throw new UnsupportedOperationException("Method has not implemented yet");
	}

}
