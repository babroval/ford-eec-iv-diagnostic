package babroval.eec_iv.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

public final class CsvUtil {

	public static List<String> loadAllLinesFromCsvFile(String csvFilePath) {

		File csvFile = new File(csvFilePath);
		List<String> allLines = new ArrayList<>();
		String line = "";

		try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {

			if (csvFile.length() == 0) {
				throw new RuntimeException("CSV file is empty");
			}

			int id = 0;
			while ((line = br.readLine()) != null) {

				line = ++id + "," + line;
				allLines.add(line);
			}
			return allLines;

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
