import 'package:apu_assignment/features/conselor/resources/model/resources_model.dart';

class ResourcesProvider {
  Future<List<ResourceItem>> fetchResources() async {
    // 模拟从文件或网络读取
    return [
      ResourceItem(
        title: "How to Prevent Bullying",
        source: "UNICEF",
        type: "articles",
        durationOrSize: "5 min",
        imageUrl: 'https://img.freepik.com/free-psd/world-day-bullying-prevention-template-design_23-2151371506.jpg?semt=ais_hybrid&w=740&q=80'
      ),
      ResourceItem(
        title: "What is Cyberbullying?",
        source: "StopBullying.gov",
        type: "articles",
        durationOrSize: "3 min",
      ),
      ResourceItem(
        title: "Be a Buddy, Not a Bully",
        source: "Edu Series",
        type: "videos",
        durationOrSize: "03:45",
      ),
      ResourceItem(
        title: "The Price of Shame",
        source: "TedTalk",
        type: "videos",
        durationOrSize: "22:10",
      ),
      ResourceItem(
        title: "Youth Mental Health Awareness Talk",
        source: "APU Counseling Unit",
        type: "events", // 新增一个类型 "event"
        durationOrSize: "2024-06-15, 10 AM", // 可以是日期时间
        imageUrl: "https://example.com/youth_talk_poster.jpg", // 假设有一个图片链接
      ),
      ResourceItem(
        title: "Walk Throught Life of Bullying",
        source: "APU Counseling Unit",
        type: "events", // 新增一个类型 "event"
        durationOrSize: "2024-07-31, 10 AM", // 可以是日期时间
        imageUrl: "https://example.com/youth_talk_poster.jpg", // 假设有一个图片链接
      ),
      ResourceItem(
        title: "Walk Throught Life of Bullying",
        source: "APU Counseling Unit",
        type: "new", // 新增一个类型 "event"
        durationOrSize: "2024-07-31, 10 AM", // 可以是日期时间
        imageUrl: "https://example.com/youth_talk_poster.jpg", // 假设有一个图片链接
      ),
      ResourceItem(
        title: "Walk Throught Life of Bullying",
        source: "APU Counseling Unit",
        type: "new", // 新增一个类型 "event"
        durationOrSize: "2024-07-31, 10 AM", // 可以是日期时间
        imageUrl: "https://example.com/youth_talk_poster.jpg", // 假设有一个图片链接
      ),
    ];
  }
}