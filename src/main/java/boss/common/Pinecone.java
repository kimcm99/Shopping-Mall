package boss.common;

import java.io.InputStream;


import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.util.Scanner;
import java.text.MessageFormat;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;
import java.util.Random;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.net.ssl.HttpsURLConnection;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.google.common.primitives.Floats;
import com.google.protobuf.Struct;
import com.google.protobuf.Value;

import boss.model.Product;
import io.grpc.ManagedChannel;
import io.pinecone.PineconeClient;
import io.pinecone.PineconeClientConfig;
import io.pinecone.PineconeConnection;
import io.pinecone.PineconeConnectionConfig;
import io.pinecone.proto.*;

//pinecone APIkey (pinecone :vector를 관리하는 db)
public class Pinecone {
	private static Pinecone instance = null;
	private String indexId = "hhenyy";
	private String projectId = "zkapdvp";
	private String host = "gcp-starter";
	private String API_KEY = "2cbe5eb8-dfa2-4080-b1c3-e4d7aadbc6e5";
	private String pineconeURL = "";
	private PineconeClient dataPlaneClient;
	private PineconeConnectionConfig connectionConfig;
	private PineconeClientConfig clientConfig;
	
	public static Pinecone getInstance() {
		if(instance == null) {
			instance = new Pinecone();
		}

		return instance;
	}
	
	//pinecone에 숫자로 바뀐 임베딩을 넣음 
	private Pinecone() {
		pineconeURL = MessageFormat.format("https://{0}-{1}.svc.environment.pinecone.io", indexId, projectId);
		clientConfig = new PineconeClientConfig()
                .withApiKey(API_KEY)
                .withEnvironment(host)
                .withProjectName(projectId);
        connectionConfig = new PineconeConnectionConfig()
                .withIndexName(indexId);


        dataPlaneClient = new PineconeClient(clientConfig);
	}
	
	//upsert의 parameter로 upsertData로 임베딩된 숫자가 들어옴 ,productId는 pid를 받음
	public void upsert(float[] upsertData, int productId) {
		// upsert
		PineconeConnection conn = dataPlaneClient.connect(connectionConfig);
        String upsertId = String.valueOf(productId);
        
        Vector upsertVector = Vector.newBuilder()
                .setId(upsertId)
                .addAllValues(Floats.asList(upsertData))
                .build();

        UpsertRequest request = UpsertRequest.newBuilder()
                .addVectors(upsertVector)
                .build();

        UpsertResponse upsertResponse = conn.getBlockingStub().upsert(request);	
        System.out.println("uid " + upsertId +" Put " + upsertResponse.getUpsertedCount() + " vectors into the index");
	}
	
	public void delete(int productId) {
		// upsert
		PineconeConnection conn = dataPlaneClient.connect(connectionConfig);
        String vectorId = String.valueOf(productId);
        
        DeleteRequest request = DeleteRequest.newBuilder()
        		.addIds(vectorId)
        		.build();

        try {
	        DeleteResponse deleteResponse = conn.getBlockingStub().delete(request);
	        System.out.println("vectorId " + vectorId +" deleted");
        } catch(Exception e) {
        	System.out.println("vectorId " + vectorId +" deleted fail");
        }
	}
	
	//임베딩두개로 코사인시밀러리티(벡터내적과비슷한것) 구하면 0~1사이의 값이 나오고 이게 높을수록 유사한것
	//저장된 상품 정보를 embedding하여 vector DB에 저장해두고 유저가 질문한 내용을 embedding하여 
	//vector DB에 query를 하면 두 개의 embedding으로 유사도를 구하게 되고 이때 코사인유사도 값이 0.8이상이면 상품추천 
	//여기서 임베딩구할때 오픈ai API씀 
	public int query(float[] queryData, int topK) {
		PineconeConnection conn = dataPlaneClient.connect(connectionConfig);

        QueryRequest queryRequest = QueryRequest
                .newBuilder()
                .addAllVector(Floats.asList(queryData))
                .setTopK(topK)
                .build();

        System.out.println("Sending query request:");
        System.out.println(queryRequest);

        QueryResponse queryResponse = conn.getBlockingStub().query(queryRequest);

        System.out.println("Got query response:");
        System.out.println(queryResponse);
        
        String res = queryResponse.getMatches(0).getId() + "," + String.valueOf(queryResponse.getMatches(0).getScore());
        
        int productId = Integer.valueOf(res.split(",")[0]);
		float score = Float.valueOf(res.split(",")[1]);
		if(score < 0.8)
			productId = -1;
        
        return productId;
	}
}